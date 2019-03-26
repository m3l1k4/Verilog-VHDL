module signal_relay(
input logic [1:0] signal_key,
input logic [11:0]  sig_0,
input logic [11:0]  sig_2,
input logic [11:0]  sig_3,
input logic [11:0]  sig_1,

output logic [11:0] sig_out,

input logic clk
);

logic [11:0] old_sig_out;

always_ff@(posedge clk) begin

	if( signal_key==0) begin

	sig_out<= sig_0;
	old_sig_out<=sig_0; end

	else if (signal_key==1) begin

	sig_out<= sig_1;
	old_sig_out<=sig_1; end

	else if (signal_key==2)  begin
	sig_out<= sig_2;
	old_sig_out<=sig_2;  end

	else if (signal_key==3)   begin
	sig_out<= sig_3;
	old_sig_out<=sig_3;  end


	else

	sig_out<= old_sig_out;


end


endmodule
