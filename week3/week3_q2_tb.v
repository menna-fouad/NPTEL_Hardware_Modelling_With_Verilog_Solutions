module shift_register_8_bit_tb;
    reg [7:0] in;
    reg clk = 0;
    reg ld, asr, lsl, clr;
    wire [7:0] out;

    shift_register_8_bit DUT (
        .in(in),
        .clk(clk),
        .ld(ld),
        .asr(asr),
        .lsl(lsl),
        .clr(clr),
        .out(out)
    );

    initial begin
        forever #5 clk = ~clk;
    end

    initial begin
        $dumpfile("shift_reg_tb.vcd");
        $dumpvars(0, shift_register_8_bit_tb);
        $monitor($time, " in=%b, clr=%b, ld=%b, asr=%b, lsl=%b, out=%b", in, clr, ld, asr, lsl, out);

        in = 8'b0;
        clr = 0; ld = 0; asr = 0; lsl = 0;

        #10 in = 8'b10000011; ld = 1;
        #10 ld = 0; asr = 1; lsl = 0; clr = 0;
        #20 in = 8'b00111010; ld = 1; // after 20 seconds for 2 right shifts
        #10 ld = 0; asr = 0; lsl = 1; clr = 0;
        #20 ld = 0; asr = 0; lsl = 0; clr = 1; // after 20 seconds for 2 left shifts
        #10 $finish;
    end
endmodule