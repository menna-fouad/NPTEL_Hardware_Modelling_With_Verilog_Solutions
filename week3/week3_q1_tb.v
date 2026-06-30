module dff_tb;
    reg clk = 0;
    reg d, rst;
    wire q;

    dff DUT(
        .d(d),
        .clk(clk),
        .rst(rst),
        .q(q)
    );

    initial begin
        forever #5 clk = ~clk;
    end

    initial begin
        $dumpfile("dff_tb.vcd");
        $dumpvars(0, dff_tb);
        $monitor($time, " d = %b, rst = %b, q = %b", d, rst, q);

        #10 d = 1; rst = 1;
        #10 d = 0; rst = 0;
        #10 d = 0; rst = 0;
        #10 d = 1; rst = 0;
        #10 $finish;
    end
endmodule