module key_moderator (keyboard_in, clk, key_out, reset, forward_backward); 

`define E_play 8'h24 
`define D_stop 8'h23
`define F_forward 8'h2b
`define B_backward 8'h2c //T key

input [7:0] keyboard_in;
input clk, reset;
output reg [7:0] key_out;

reg play_stop;

reg old_dir;
output reg forward_backward;
// play 1 stop 0
// forward 1 backward 0 



enum { check_play, check_dir} state;

always_ff@(posedge clk) begin

if(reset) begin

play_stop<=1;
forward_backward<=1;
key_out<=0;
old_dir<=1;
state<=check_play;



end

else begin

case(state)


	check_play: begin

		if ( keyboard_in == `E_play) begin
		play_stop<= 1;
		forward_backward<= old_dir;
		key_out<= `E_play;
		state<= check_dir;

	end
		else
		state<=check_play;


	end
	
	
	check_dir: begin
	
	if ( keyboard_in == `F_forward| keyboard_in == `B_backward) begin
		 
		 if (keyboard_in == `F_forward) begin
		 
			if ( play_stop == 1) begin
			
				play_stop<=1;
				forward_backward<=1;
				old_dir<= 1;	
				key_out<=`E_play;
			
			end
			
			
			else if ( play_stop == 0) begin
			
				play_stop<=0;
				forward_backward<=1;
				old_dir<= 1;	
				key_out<=`D_stop;
			
			end
		end
			
		else if ( keyboard_in == `B_backward) begin
		 
			if ( play_stop == 1) begin
			
				play_stop<=1;
				forward_backward<=0;
				old_dir<= 0;	
				key_out<=`E_play;
			
			end
			
			
			else if ( play_stop == 0) begin
			
				play_stop<=0;
				forward_backward<=0;
				old_dir<= 0;	
				key_out<=`D_stop;
			
			end
					
		
		end
	end
		
		
		else if ( keyboard_in == `E_play | keyboard_in == `D_stop) begin
		
			if ( keyboard_in == `E_play) begin
			
				play_stop<=1;
				forward_backward<=old_dir;
				old_dir<= old_dir;	
				key_out<=`E_play;
			
			end
			
			
			else if ( keyboard_in == `D_stop) begin
				
				play_stop<=0;
				forward_backward<=old_dir;
				old_dir<= old_dir;	
				key_out<=`D_stop;
			
			end
		
		
		
		end
			
			
		else begin
		
			if ( forward_backward == 1) begin
				
				if ( play_stop == 1) begin
				
				play_stop<= 1;
				forward_backward<=1;
				old_dir<= 1;
				key_out<= `E_play;
				
				end
				else begin
				
				play_stop<= 0;
				forward_backward<=1;
				old_dir<= 1;
				key_out<= `D_stop;
				
				end
			
			end
			
			
			else if ( forward_backward == 0) begin
				
				if ( play_stop == 1) begin
				
				play_stop<= 1;
				forward_backward<=0;
				old_dir<= 0;
				key_out<= `E_play;
				
				end
				
				else begin
				
				play_stop<= 0;
				forward_backward<=0;
				old_dir<= 0;
				key_out<= `D_stop;
				
				end			
			
			
			
			end
		


		end		
		 
		 state<=check_dir;
		 end
	

default: state<=check_play;
	
			

endcase
end


end




endmodule 