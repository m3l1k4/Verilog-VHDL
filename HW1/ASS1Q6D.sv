module NregAS ( in,out, en, reset , CLOCK_50);

parameter N = 2;

input CLOCK_50;
input logic [N-1:0] in;
input logic reset,en;
output logic [N-1:0] out;


always_ff@( posedge CLOCK_50, posedge reset) begin

if(reset)

out <= 0;

else if (en) 
out<=in; 

end 


endmodule