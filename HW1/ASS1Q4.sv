// HW#1 Question #4 
module test(one,two,three,four,five,six,seven,eight,
,key,out);

input [31:0] one,two,three,four,five,six,seven,eight;
output reg [31:0] out;
reg [31:0] old_out;
input [2:0] key;

assign old_out = out;

always@(*) begin

if (key == 3'b000) out = one;
else if (key == 3'b001) out = two;
else if (key == 3'b010) out = three;
else if (key == 3'b011) out = four;
else if (key == 3'b100) out = five;
else if (key == 3'b101) out = six;
else if (key == 3'b110) out = seven;
else if (key == 3'b111) out = eight;
else out = old_out;


end
endmodule