module sum_series_ctrlpath(
    output reg LoadN,
    output reg LoadR,
    output reg Clear,
    output reg IncC,
    output reg Stop,
    input wire clk,
    input wire CltN,
    input wire Start
);
    parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10, S3 = 2'b11;
    reg [1:0] state;

    always @(posedge clk) begin
        case (state)
            S0 : if (Start) state <= S1;
            S1 : state <= S2;
            S2 : begin
                if (CltN) state <= S3;
                else state <= S2;
            end
            S3 : state <= S3;
            default : state <= S0;
        endcase
    end

    always @(state) begin
        LoadN = 0;
        LoadR = 0;
        Clear = 0;
        IncC = 0;
        Stop = 0;
        case (state)
            S0 : Clear = 1;
            S1 : LoadN = 1;
            S2 : begin
                LoadR = 1;
                IncC = 1;
            end
            S3 : Stop = 1;
        endcase
    end
endmodule