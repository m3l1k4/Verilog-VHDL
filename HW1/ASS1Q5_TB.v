 // HW#1 Question #5 TB
module test_tb1();

reg [7:0] in;
wire [2:0] out;

test test(.in(in), .out(out));


initial begin

in = 8'b00100101;


end

endmodule