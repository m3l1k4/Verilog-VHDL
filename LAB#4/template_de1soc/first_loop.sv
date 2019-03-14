module first_loop (

input logic clk,
input logic reset_n,
output logic [7:0] address,
output logic [7:0] data,
output logic wren,
output logic done_flag,
//input logic start_flag,

input logic start_over,
input logic new_key_incoming


 
); 
integer addr_inc = 0;  // used to increment address


enum  { start_over_state, calcs, done} state;


always_ff@(posedge clk, negedge reset_n) begin

	if ( reset_n==0 ) begin
	
		address<=0;
		addr_inc<=0;
		wren <=0;
		done_flag<=0;

		state<= calcs;
	end
	

	else begin
	
	case(state)
	
	start_over_state: begin
		address<=0;
		addr_inc<=0;
		wren <=0;
		done_flag<=0;

		state<= calcs;
	
	
	end
	
	calcs: begin
		if ( addr_inc<256) begin
		
			
			address<= addr_inc;
			data<= addr_inc;
			addr_inc<= addr_inc + 1;
			
			wren<= 1;
			done_flag<=0;
			
			end 
			
		else begin

			wren <=0;
			done_flag<=1;
			state<= done;
		
		end
	end 
	
	 
	done: begin
	
	if (start_over) state<= start_over_state;
	else state<=done;
	
	end
	
	
		
	endcase 
	
	end
	
end




endmodule 