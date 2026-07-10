module buttonpress (
    input clk, y,
    output reg e
);
    localparam A = 1'b0, B = 1'b1;

    reg NS = A, PS = A;
    
    always @(posedge clk) begin
        PS <= NS;
    end

    always @(*) begin
        case (PS)
            A : begin
                e = y ? 1'b0 : 1'b1; // If the bell is not pressed (y = 1), don't ring, otherwise ring
                NS = y ? A : B; // If the bell is still not pressed, remain in A, otherwise go to B
            end
            B : begin
                e = y ? 1'b1 : 1'b0; // If the bell goes from pressed to unpressed then ring, otherwise don't ring
                NS = y ? A : B; // If the bell is not pressed go to state A (not pressed), otherwise remain in state B (pressed)
            end
            default : begin
                NS = A;
                e = 1'b0;
            end
        endcase
    end
endmodule