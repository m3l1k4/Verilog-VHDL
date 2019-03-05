module second_loop(

input logic clk,
input logic reset_n,
output logic [7:0] address,
output logic [7:0] data,
input logic [7:0] data_read,
output logic wren,
input logic [23:0] keys,





);


enum { read_i, 


assign keys[23:10] = 0

logic [22:0] i, j;
logic [7:0] data_i, data_j;


always_ff@(posedge clk, negedge reset_n) begin

	if(!reset_n) begin
		
		i<=0;
		j<=0;
		wren<= 0;
		state<= read_i;
	
	end

	
	else begin
		case(state) 
		
			read_i: begin
				
				if ( i<256) begin
				
					address<= i;
					wren<= 0;
					state<= wait_i;
				
				end
				
				else 
				
					state<= finish;
				
			end
			
			
			wait_i: state<= wait_i_2;
			wait_i_2: state<= save_i;
			
			save_i: begin
			
			data_i<= data_read;
			j<= (j + data_read + keys)
			
			
			end
			
			
			
			
			
			
			
		
		endcase
	end

end



endmodule