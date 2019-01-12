module latch( CLOCK_50, in, out);

input logic [7:0] in;
output logic [7:0] out;
input CLOCK_50;

always_latch begin

if (CLOCK_50)
out<=in;

end




endmodule