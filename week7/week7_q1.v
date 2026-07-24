module adder_rom_2bit(
    output Cout,
    output [1:0] Sum,
    input [1:0] A,
    input [1:0] B,
    input C
);
    reg [2:0] ROM [0:31];
    integer k;

    initial begin
        for (k = 0; k < 32; k = k + 1) begin
            ROM[k] = sum_carry(k);
        end
    end

    assign {Cout, Sum} = ROM[{A, B, C}];

    function [2:0] sum_carry(
        input [4:0] k
    );
        reg [1:0] A, B;
        reg C_in;
        reg G0, G1;
        reg P0, P1;
        reg C1, C2;

        begin
            {A, B, C_in} = k;

            G0 = A[0] & B[0];
            G1 = A[1] & B[1];

            P0 = A[0] ^ B[0];
            P1 = A[1] ^ B[1];

            C1 = G0 | P0 & C_in;
            C2 = G1 | P1 & G0 | P1 & P0 & C_in;

            sum_carry[0] = P0 ^ C_in;
            sum_carry[1] = P1 ^ C1;
            sum_carry[2] = C2;
        end
    endfunction
endmodule