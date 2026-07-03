`default_nettype none
module bcd_encoder_tb;
    reg [9:0] in;
    reg enable;
    wire [3:0] out;

    bcdencoder DUT(.in(in), .enable(enable), .out(out));

    initial begin
        $monitor($time, " enable = %b, in = %b, out = %b", enable, in, out);
        $dumpfile("bcd_encoder_tb.vcd");
        $dumpvars(0, bcd_encoder_tb);
        enable = 1; in = 10'b0000000010;
        #5 in = 10'b0000010000;
        #5 in = 10'b0100000000;
        #5 in = 10'b0000001000;
        #5 $finish;
    end
endmodule