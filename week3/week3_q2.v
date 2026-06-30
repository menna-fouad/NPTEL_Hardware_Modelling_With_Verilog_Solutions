module shift_register_8_bit(
    input[7:0] in,
    input clk, ld, asr, lsl, clr,
    output reg[7:0] out
);
    always @(posedge clk) begin
        if (clr) begin
            out <= 8'b0;
        end
        else if (ld) begin
            out <= in;
        end
        else if (asr) begin
            out <= {out[7], out[7:1]};
        end
        else if (lsl) begin
            out <= {out[6:0], 1'b0};
        end
    end
endmodule