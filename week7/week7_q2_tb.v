module pipeline_tb;
    reg clk = 0;
    reg [7:0] X, Y;
    reg Cin;
    wire [7:0] Sum;
    wire Cout;

    pipe_adder_8bit adder (
        .clk(clk),
        .X(X),
        .Y(Y),
        .Cin(Cin),
        .Sum(Sum),
        .Cout(Cout)
    );

    initial begin
        $dumpfile("pipeline.vcd");
        $dumpvars(0, pipeline_tb);
        #200 $finish;
    end

    always #5 clk = ~clk;

    initial begin
        #2  X = 0;   Y = 0;   Cin = 1; // Cout = 0, Sum = 1
        #10 X = 128; Y = 160; Cin = 0; // Cout = 1, Sum = 32
        #10 X = 64;  Y = 32;  Cin = 0; // Cout = 0, Sum = 96
        #10 X = 192; Y = 128; Cin = 1; // Cout = 1, Sum = 65
    end

    initial begin
        #47 check(0, 0, 1, Sum, Cout);
        #10 check(128, 160, 0, Sum, Cout);
        #10 check(64, 32, 0, Sum, Cout);
        #10 check(192, 128, 1, Sum, Cout);
    end

    task check(
        input [7:0] a, b,
        input c_in, 
        input [7:0] sum,
        input c_out
    );
        reg [8:0] expected;
        begin
            expected = a + b + c_in;
            if (expected == {c_out, sum}) begin
                $display("PASSED | Expected : Sum = %d, Carry = %b | Got : Sum = %d, Carry = %b", 
                        expected[7:0], expected[8], sum, c_out);
            end
            else begin
                $display("FAILED | Expected : Sum = %d, Carry = %b | Got : Sum = %d, Carry = %b", 
                        expected[7:0], expected[8], sum, c_out);
            end
        end
    endtask
endmodule