module reg9( CLOCK_50, in, out, reset);

input CLOCK_50;
input logic [8:0] in;
input logic reset;
output logic [8:0] out;


always_ff @( posedge CLOCK_50, posedge reset) begin

if (reset)
out<= 0;

else
out<= in;


end 


endmodule