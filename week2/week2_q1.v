module half_adder(
    input X, Y,
    output S, C
);
    xor G1(S, X, Y);
    and G2(C, X, Y);
endmodule