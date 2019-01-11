module Nreg ( in,out, reset , CLOCK_50);

parameter N = 2;

input CLOCK_50;
input logic [N-1:0] in;
input logic reset;
output logic [N-1:0] out;


always_ff@( posedge CLOCK_50) begin

if(reset)

out <= 0;

else 
out<=in; 

end 



endmodule