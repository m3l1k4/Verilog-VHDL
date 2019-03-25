module sending_subsys(
input logic en,
input logic reset,
input logic clk_send,
output logic en_level

);


logic D;



always_ff@( posedge clk_send, posedge reset) begin

if (reset) // if reset
en_level<=0;  // out is zero

else 

en_level<=D; // else out is in

end 

assign D =(en?(~en_level): en_level );

endmodule 