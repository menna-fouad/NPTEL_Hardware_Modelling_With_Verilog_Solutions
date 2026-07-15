module sum_series_datapath(
    output CltN,
    input LoadN,
    input LoadR,
    input Clear,
    input IncC,
    input [7:0] Data_in,
    input clk
);
    wire [7:0] N, R, C, res;

    register NRegister (
        .clk(clk),
        .load(LoadN),
        .clear(Clear),
        .data_in(Data_in),
        .out(N)
    );

    register RRegister (
        .clk(clk),
        .load(LoadR),
        .clear(Clear),
        .data_in(res),
        .out(R)
    );

    counter count (
        .clk(clk),
        .clear(Clear),
        .inc(IncC),
        .out(C)
    );

    assign res = R + C;
    assign CltN = (C >= N);
endmodule

module register(
    input clk,
    input load,
    input clear,
    input [7:0] data_in,
    output reg [7:0] out
);
    always @(posedge clk) begin
        if (clear) out <= 8'b0;
        else if (load) out <= data_in;
    end
endmodule

module counter(
    input clk,
    input clear,
    input inc,
    output reg [7:0] out
);
    always @(negedge clk) begin
        if (clear) out <= 8'b0;
        else if (inc) out <= out + 1;
    end
endmodule
