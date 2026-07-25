module testbench2;
    // Load a program from a specific memory address (e.g. 0)
    // Initialize PC to the address of the first instruction (0)

    initial begin
        $dumpfile("mips_test2.vcd");
        $dumpvars(0, testbench2);
        #600 $finish;
    end

    reg clk1, clk2;
    initial begin
        clk1 = 0; clk2 = 0;
        repeat (25) begin
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

        processor.mem[120] = 32'd85;

        processor.mem[0] = 32'b00101000000000010000000001111000; // ADDI R1, R0, 120
        processor.mem[1] = 32'b00001100110001100011000000000000; // OR   R6, R6, R6 - Dummy instruction to avoid RAW Data Hazard
        processor.mem[2] = 32'b00100000001000100000000000000000; // LW   R2, 0(R1)
        processor.mem[3] = 32'b00001100110001100011000000000000; // OR   R6, R6, R6 - Dummy instruction to avoid RAW Data Hazard
        processor.mem[4] = 32'b00101000010000110000000000101101; // ADDI R3, R2, 45
        processor.mem[5] = 32'b00001100110001100011000000000000; // OR   R6, R6, R6 - Dummy instruction to avoid RAW Data Hazard
        processor.mem[6] = 32'b00100100001000110000000000000001; // SW   R3, 1(R1)
        processor.mem[7] = 32'b11111100000000000000000000000000; // HALT

        processor.PC = 1'b0;
        processor.HALTED = 1'b0;
        processor.TAKEN_BRANCH = 1'b0;

        #500;
        $display("MEM[120] = %0d", processor.mem[120]);
        $display("MEM[121] = %0d", processor.mem[121]);
        check();
    end

    task check();
    reg [31:0] expected;
        begin
            expected = processor.mem[120] + 45;
            if (processor.mem[121] != expected) begin
                $display("FAILED | Expected : %0d | Got : %0d",
                        expected, processor.mem[121]);
            end else begin
                $display("PASSED | Expected : %0d | Got : %0d",
                        expected, processor.mem[121]);
            end
        end
    endtask
endmodule