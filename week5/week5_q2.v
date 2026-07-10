module timercontroller (
    output reg x, 
    input b, clk
);
    localparam Off = 2'b00, On1 = 2'b01, On2 = 2'b10, On3 = 2'b11;
    reg [1:0] PS = Off;

    always @(posedge clk) begin
        case (PS)
            Off : PS <= b ? On1 : Off;
            On1 : PS <= On2;
            On2 : PS <= On3;
            On3 : PS <= Off;
        endcase
    end
    
    always @(*) begin
        case (PS)
            Off: x = 1'b0;
            On1, On2, On3: x = 1'b1;
            default: x = 1'b0;
        endcase
    end
endmodule