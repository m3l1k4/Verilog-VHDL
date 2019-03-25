module sig_mod_2(
input clock,
//input reset,
input logic sync_sig,
input lfsr_0,
input [11:0] org_wave,
output logic [11:0] mod_sig

);

logic [11:0] OW;

assign   mod_sig = {12{lfsr_0}}&OW;
//{n{VARIABLE}}

always_comb begin



		if ( lfsr_0 == 1) begin
		OW<= ~org_wave;
		end
		
		else begin
		
		OW<=org_wave;
		end


end


endmodule
