// register without enable
module reg8 ( CLOCK_50,in, out);

input [7:0] in;
output logic [7:0] out;
input CLOCK_50;



always_ff@( posedge CLOCK_50) begin

out <= in; 

end 

// reference pg 115 of course textbook 

endmodule

//////////////////////////////////////////////////////////////////////////

//register with enable 
module reg8 ( CLOCK_50, en,in, out);

input [7:0] in;
input en;
output logic [7:0] out;
logic [7:0] hold_val;
input CLOCK_50;

assign hold_val = out;

always_ff@( posedge CLOCK_50) begin

if ( en == 1) begin

out <= in;
end
else begin
out <= hold_val;

end

end

endmodule 