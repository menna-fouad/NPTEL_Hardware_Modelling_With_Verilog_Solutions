module pipe_adder_8bit(
    output Cout,
    output [7:0] Sum,
    input [7:0] X,
    input [7:0] Y,
    input Cin,
    input clk
);
    reg [7:0] L12_X, L12_Y;
    reg [1:0] L12_sum;
    reg L12_carry;

    reg [7:0] L23_X, L23_Y;
    reg [3:0] L23_sum;
    reg L23_carry;

    reg [7:0] L34_X, L34_Y;
    reg [5:0] L34_sum;
    reg L34_carry;

    reg [7:0] L45_sum;
    reg L45_carry;

    wire [1:0] sum0, sum1, sum2, sum3;
    wire carry1, carry2, carry3, carry4;

    adder_rom_2bit adder0 (.A(X[1:0]), .B(Y[1:0]), .C(Cin), .Sum(sum0), .Cout(carry1));
    adder_rom_2bit adder1 (.A(L12_X[3:2]), .B(L12_Y[3:2]), .C(L12_carry), .Sum(sum1), .Cout(carry2));
    adder_rom_2bit adder2 (.A(L23_X[5:4]), .B(L23_Y[5:4]), .C(L23_carry), .Sum(sum2), .Cout(carry3));
    adder_rom_2bit adder3 (.A(L34_X[7:6]), .B(L34_Y[7:6]), .C(L34_carry), .Sum(sum3), .Cout(carry4));

    always @(posedge clk) begin
        L12_X <= X;
        L12_Y <= Y;
        L12_sum <= #3 sum0;
        L12_carry <= #2 carry1;
    end

    always @(posedge clk) begin
        L23_X <= L12_X;
        L23_Y <= L12_Y;
        L23_sum <= #3 {sum1, L12_sum};
        L23_carry <= #2 carry2;
    end

    always @(posedge clk) begin
        L34_X <= L23_X;
        L34_Y <= L23_Y;
        L34_sum <= #3 {sum2, L23_sum};
        L34_carry <= #2 carry3;
    end

    always @(posedge clk) begin
        L45_sum <= #3 {sum3, L34_sum};
        L45_carry <= #2 carry4;
    end

    assign Sum = L45_sum;
    assign Cout = L45_carry;
endmodule