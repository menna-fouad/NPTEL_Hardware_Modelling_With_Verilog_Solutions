module adder_rom_tb;
    reg [1:0] a, b;
    reg c_in;
    wire [1:0] sum;
    wire c_out;
    integer k;

    adder_rom_2bit rom (
        .A(a),
        .B(b),
        .C(c_in),
        .Cout(c_out),
        .Sum(sum)
    );

    initial begin
        $dumpfile("adder_rom.vcd");
        $dumpvars(0, adder_rom_tb);
        $monitor($time, " A = %d, B = %d, C = %b", a, b, c_in);
        #200 $finish;
    end

    initial begin
        for (k = 0; k < 32; k = k + 1) begin
            a = k[4:3]; b = k[2:1]; c_in = k[0];
            #5 check(a, b, c_in, sum, c_out);
        end
    end

    task check(
        input [1:0] a, b,
        input c_in, 
        input [1:0] sum,
        input c_out
    );
        reg [2:0] expected;
        begin
            expected = a + b + c_in;
            if (expected == {c_out, sum}) begin
                $display("PASSED | Expected : Sum = %b, Carry = %b | Got : Sum = %b, Carry = %b", 
                        expected[1:0], expected[2], sum, c_out);
            end
            else begin
                $display("FAILED | Expected : Sum = %b, Carry = %b | Got : Sum = %b, Carry = %b", 
                        expected[1:0], expected[2], sum, c_out);
            end
        end
    endtask
endmodule