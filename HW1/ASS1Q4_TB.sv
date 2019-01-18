// HW#1 Question #4 testbench
module test_tb1();

reg [4:0] one,two,three,four,five,six,seven,eight;
wire [4:0] out;
reg [2:0] key;

test test(.one(one),.two(two),.three(three),.four(four),.five(five),.six(six),.seven(seven),.eight(eight),
.key(key),.out(out));


initial begin

key = 3'b001;

one = 5'b00001;
two = 5'b01001;
three = 5'b01001;
four = 5'b01010;
five = 5'b00101;
six = 5'b00101;
seven = 5'b01110;
eight = 5'b01011;
#10;


end

endmodule