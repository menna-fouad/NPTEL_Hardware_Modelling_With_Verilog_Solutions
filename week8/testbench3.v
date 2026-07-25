module testbench3;
    // Load a program from a specific memory address (e.g. 0)
    // Initialize PC to the address of the first instruction (0)

    initial begin
        $dumpfile("mips_test3.vcd");
        $dumpvars(0, testbench3);
        #3000 $finish;
    end


    reg clk1, clk2;
    initial begin
        clk1 = 0; clk2 = 0;
        repeat (150) begin
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

        processor.mem[200] = 32'd10;

        processor.mem[0] = 32'b00101000000000010000000011001000; // ADDI R1, R0, 200
        processor.mem[1] = 32'b00101000000000100000000000000001; // ADDI R2, R0, 1
        processor.mem[2] = 32'b00100000001000110000000000000000; // LW   R3, 0(R1)
        processor.mem[3] = 32'b00001100110001100011000000000000; // OR   R6, R6, R6 - Dummy instruction to avoid RAW Data Hazard
        processor.mem[4] = 32'b00010100011000100001000000000000; // MUL R2, R2, R3
        processor.mem[5] = 32'b00101100011000110000000000000001; // SUBI R3, R3, 1
        processor.mem[6] = 32'b00001100110001100011000000000000; // OR    R6, R6, R6 - dummy (SUBI->BNEQZ hazard)
        processor.mem[7] = 32'b00110100011000001111111111111100; // BNEQZ R3, LOOP
        processor.mem[8] = 32'b00100100001000101111111111111110; // SW   R3, -2(R1)
        processor.mem[9] = 32'b11111100000000000000000000000000; // HALT

        processor.PC = 1'b0;
        processor.HALTED = 1'b0;
        processor.TAKEN_BRANCH = 1'b0;

        #2800;
        $display("MEM[200] = %0d", processor.mem[200]);
        $display("MEM[198] = %0d", processor.mem[198]);
        check();
    end

    task check();
    reg [31:0] expected;
        begin
            expected = 32'd3628800;
            if (processor.mem[198] !== expected) begin
                $display("FAILED | Expected : %0d | Got : %0d",
                        expected, processor.mem[198]);
            end else begin
                $display("PASSED | Expected : %0d | Got : %0d",
                        expected, processor.mem[198]);
            end
        end
    endtask
endmodule