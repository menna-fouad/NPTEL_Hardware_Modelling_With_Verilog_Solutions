`timescale 1ns/1ps

module half_adder_tb;
    reg x, y;
    wire sum, carry;
    half_adder DUT(.X(x), .Y(y), .S(sum), .C(carry));

    initial begin
        $dumpfile("half_adder_tb.vcd");
        $dumpvars(0, half_adder_tb);
        $monitor($time, " x = %d, y = %d, sum = %d, carry = %d", x, y, sum, carry);

        #5 x = 0; y = 0;
        #5 x = 0; y = 1;
        #5 x = 1; y = 0;
        #5 x = 1; y = 1;
    end
endmodule