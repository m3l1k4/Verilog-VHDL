module sig_mod(

input logic sig_synced_flag,
input [11:0] sin_sig,
input LFSR_0_sig,
output logic [11:0] mododed_sig

);


always_comb begin

if ( sig_synced_flag)

mododed_sig = 0*sin_sig;

else 
mododed_sig = sin_sig;


end


endmodule