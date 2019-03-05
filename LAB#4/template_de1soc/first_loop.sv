module first_loop (

input logic clk,
input logic reset_n,
output logic [7:0] address,
output logic [7:0] data,
output logic wren

);

logic [22:0] addr_inc;  // used to increment address


always_ff@(posedge clk, negedge reset_n) begin

	if ( !reset_n) begin
	
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
			
			end 
			
		else begin

			wren <=0;
		
		end
		
	
	
	end
	
end




endmodule 