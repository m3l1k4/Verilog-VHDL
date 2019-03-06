module first_loop (

input logic clk,
input logic reset_n,
output logic [7:0] address,
output logic [7:0] data,
output logic wren,
output logic done_flag,
input logic start_flag

); 

logic [22:0] addr_inc;  // used to increment address


always_ff@(posedge clk) begin

	if ( !start_flag) begin
	
		address<=0;
		addr_inc<=0;
		wren <=0;	
		
	end
	
	else begin
	
		if ( addr_inc<256) begin
		
			addr_inc<= addr_inc + 1;
			address<= addr_inc;
			data<= addr_inc;
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