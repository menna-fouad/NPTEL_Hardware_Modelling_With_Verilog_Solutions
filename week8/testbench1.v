module testbench1;
    // Load a program from a specific memory address (e.g. 0)
    // Initialize PC to the address of the first instruction (0)

    initial begin
        $dumpfile("mips_test1.vcd");
        $dumpvars(0, testbench1);
        #300 $finish;
    end

    reg clk1, clk2;
    initial begin
        clk1 = 0; clk2 = 0;
        repeat (20) begin
            #5 clk1 = 1'b1; #5 clk1 = 1'b0;
            #5 clk2 = 1'b1; #5 clk2 = 1'b0;
        end
    end

    MIPS32 processor (
        .clk1(clk1),
        .clk2(clk2)
    );

    integer k;
    initial begin
        for (k = 0; k < 32; k = k + 1) begin
            processor.reg_file[k] = k;
        end

        processor.mem[0] = 32'b00101000000000010000000000001010; // ADDI R1, R0, 10
        processor.mem[1] = 32'b00101000000000100000000000010100; // ADDI R2, R0, 20
        processor.mem[2] = 32'b00101000000000110000000000011001; // ADDI R3, R0, 25
        processor.mem[3] = 32'b00101000000000010000000000001010; // ADDI R1, R0, 10
        processor.mem[4] = 32'b00000000001000100010000000000000; // ADD  R4, R1, R2
        processor.mem[5] = 32'b00001100110001100011000000000000; // OR   R6, R6, R6 - Dummy instruction to avoid RAW Data Hazard
        processor.mem[6] = 32'b00000000100000110010100000000000; // ADD  R5, R4, R3
        processor.mem[7] = 32'b11111100000000000000000000000000; // HALT

        processor.PC = 1'b0;
        processor.HALTED = 1'b0;
        processor.TAKEN_BRANCH = 1'b0;

        #280;
        for (k = 0; k < 6; k = k + 1) begin
            $display("R%0d = %0d", k, processor.reg_file[k]);
        end
        check();
    end

    task check();
    reg [31:0] r1_add_r2, sum;
        begin
            r1_add_r2 = processor.reg_file[1] + processor.reg_file[2];
            sum = processor.reg_file[1] + processor.reg_file[2] + processor.reg_file[3];

            if (processor.reg_file[4] != r1_add_r2) begin
                $display("FAILED : Error computing R1 + R2 | Expected : %0d | Got : %0d",
                        r1_add_r2, processor.reg_file[4]);
            end else if (processor.reg_file[5] != sum) begin
                $display("FAILED : Error computing final sum | Expected : %0d | Got : %0d",
                        sum, processor.reg_file[5]);
            end else begin
                $display("PASSED : Computed correct sum | Expected : %0d | Got : %0d",
                        sum, processor.reg_file[5]);
            end
        end
    endtask
endmodule