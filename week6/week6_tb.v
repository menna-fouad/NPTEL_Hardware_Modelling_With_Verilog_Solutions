module sum_series_tb;
    wire load_n, load_r, clear, inc, CltN, stop;
    reg clk, start;
    reg [7:0] data;

    sum_series_datapath datapath (
        .CltN(CltN),
        .LoadN(load_n),
        .LoadR(load_r),
        .Clear(clear),
        .IncC(inc),
        .Data_in(data),
        .clk(clk)
    );

    sum_series_ctrlpath controller (
        .LoadN(load_n),
        .LoadR(load_r),
        .Clear(clear),
        .IncC(inc),
        .Stop(stop),
        .clk(clk),
        .CltN(CltN),
        .Start(start)
    );

    initial begin
        $dumpfile("sum_series.vcd");
        $dumpvars(0, sum_series_tb);
        $monitor($time, " N = %b, Counter = %b, Result = %b", 
                datapath.N, datapath.C, datapath.R);
        #500 $finish;
    end

    always #5 clk = ~clk;
    initial begin
        clk = 1'b0;
        start = 0;
        data = 8'd4;
        #10 start = 1;
        #10 start = 0;

        @(posedge stop);
        $display("Expected: 10 | Got: %d", datapath.R);
    end
endmodule