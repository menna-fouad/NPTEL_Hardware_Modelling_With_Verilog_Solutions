module full_adder_tb;
    reg[1:0] x, y;
    reg cin;
    wire[1:0] sum;
    wire carry;
    full_adder_2bit DUT(.A(x), .B(y), .Cin(cin), .Sum(sum), .Carry(carry));

    initial begin
        $dumpfile("fulll_adder_tb.vcd");
        $dumpvars(0, full_adder_tb);
        $monitor($time, " x = %d, y = %d, cin = %d, sum = %d, carry = %d", x, y, cin, sum, carry);

        #5 x = 2'b00; y = 2'b01; cin=0;
        #5 x = 2'b01; y = 2'b00; cin=1;
        #5 x = 2'b10; y = 2'b10; cin=1;
        #5 x = 2'b00; y = 2'b00; cin=0;
    end
endmodule;