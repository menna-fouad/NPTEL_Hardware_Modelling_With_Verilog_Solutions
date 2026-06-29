module full_adder_2bit(
    input [1:0] A, B,
    input Cin,
    output [1:0] Sum,
    output Carry
);
    wire bit0_sum1, bit0_carry1, bit0_carry2, bit0_carry;
    half_adder add1(.X(A[0]), .Y(B[0]), .S(bit0_sum1), .C(bit0_carry1));
    half_adder add2(.X(bit0_sum1), .Y(Cin), .S(Sum[0]), .C(bit0_carry2));
    or G0(bit0_carry, bit0_carry1, bit0_carry2);

    wire bit1_sum1, bit1_carry1, bit1_carry2, bit1_carry;
    half_adder add3(.X(A[1]), .Y(B[1]), .S(bit1_sum1), .C(bit1_carry1));
    half_adder add4(.X(bit1_sum1), .Y(bit0_carry), .S(Sum[1]), .C(bit1_carry2));
    or G1(Carry, bit1_carry1, bit1_carry2);
endmodule