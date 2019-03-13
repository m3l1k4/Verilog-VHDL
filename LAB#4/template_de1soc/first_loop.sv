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


always_ff@(posedge clk, negedge reset_n) begin

	if ( reset_n==0 
	//|| start_over == 1
	) begin
	
		address<=0;
		addr_inc<=0;
		wren <=0;
		done_flag<=0;

		
	end
	
	
	else if (start_over == 1) begin
	
		address<=0;
		addr_inc<=0;
		wren <=0;
		done_flag<=0;

	
	end
	
	
	else begin
	
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
		
		end
		
	
	
	end
	
end




endmodule 