module timer_tb;
    reg clk, b;
    wire x;
    timercontroller timer(.x(x), .b(b), .clk(clk));

    initial begin
        $dumpfile("timer.vcd");
        $dumpvars(0, timer_tb);
        $monitor("b = %b, PS = %b, x = %b", b, timer.PS, x);
        clk = 1'b0;
        #100 $finish;
    end

    always #5 clk = ~clk;

    initial begin
        b = 1'b0;
        #10 b = 1'b1;
        #20 b = 1'b0; // Show that timer doesn't reset once it started
        #30 b = 1'b1; // let b = 0 for the first clock cycle after the timer finishes, 
        // then set it to 1 at the second clock cycle
    end
endmodule