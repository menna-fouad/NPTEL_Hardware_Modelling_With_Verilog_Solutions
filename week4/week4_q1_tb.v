`default_nettype none
module comparator_tb;
    reg A1, A2, A3, B1, B2, B3;
    wire C;

    udpcomparator DUT(C, A1, A2, A3, B1, B2, B3);
    initial begin
        $monitor($time, " A = %b%b%b, B = %b%b%b, C = %b", A1, A2, A3, B1, B2, B3, C);
        $dumpfile("comparator_tb.vcd");
        $dumpvars(0, comparator_tb);

        #0 A1 = 0; A2 = 1; A3 = 0; B1 = 0; B2 = 1; B3 = 0;
        #5 A1 = 1; A2 = 1; A3 = 0; B1 = 1; B2 = 1; B3 = 1;
        #5 A1 = 0; A2 = 1; A3 = 1; B1 = 0; B2 = 0; B3 = 1;
        #5 A1 = 0; A2 = 0; A3 = 1; B1 = 0; B2 = 0; B3 = 0;
        #5 $finish;
    end
endmodule