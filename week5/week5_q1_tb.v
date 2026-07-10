module bell_tb;
    reg y, clk;
    wire e;
    
    buttonpress bell(.clk(clk), .y(y), .e(e));
    always #5 clk = ~clk;

    initial begin
        $dumpfile("bell.vcd");
        $dumpvars(0, bell_tb);
        $monitor($time, " PS = %b, y = %b | e = %b, NS = %b", bell.PS, y, e, bell.NS);
        clk = 1'b0;
        #50 $finish;
    end

    initial begin
        y = 1'b1;
        #10 y = 1'b0;
        #10 y = 1'b0;
        #10 y = 1'b1;
    end
endmodule