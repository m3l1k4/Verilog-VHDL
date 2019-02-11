module reset_translate( keybd_data, clck, reset_signal, play_signal);

input logic [7:0]  play_signal;
input clck, keybd_data;
output logic reset_signal;
//logic [7:0] signal_track;



enum {play} state;

always @(posedge clck) begin

if ( play_signal == 8'h24) begin

reset_signal<= 0;

state<= play;

end

else begin

case(state)

	play: begin
		
		
		if ( play_signal ==  8'h2d ) begin
		
		reset_signal<=1;
		state<=play;
		
		end
		
		
		else if (play_signal == 8'h2d) begin
		
		reset_signal<= 0;
		state<= play;
		
		end
		
		
		else begin
		
		reset_signal<= 0 ;
		state<=play;
		
		end
	
	end


endcase

end


end

endmodule
