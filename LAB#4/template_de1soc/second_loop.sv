module second_loop(

input logic clk,
input logic reset_n,
output logic [7:0] address,
output logic [7:0] data,
input logic [7:0] data_read,
output logic wren,
input logic [23:0] keys,

input logic start_flag,
output logic done_flag





);


enum { read_i, 


//assign keys[23:10] = 0

logic [22:0] i, j;
reg [7:0] data_i, data_j;


always_ff@(posedge clk) begin

	if(!start_flag) begin
		
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
					done_flag<=0;
				
				end
				
				else 
				
					state<= finish;
				
			end
			
			
			wait_i: state<= wait_i_2;
			wait_i_2: state<= save_i;
			
			save_i: begin
			
			data_i<= data_read;
			j<= (j + data_read + keys)
			done_flag<=0;
			
			
			end
			
			get_j: begin
			
				address<= j;
				wren<= 0;
				done_flag<=0;
				state<= wait_j;
			
			end
			
			wait_j: state<= wait_i_2;
			wait_i_2: state<= save_j;
			
			save_j: begin
			
			data_j<= data_read;
			
			state<= write_i;
			
			end
			
			write_i: begin
			
				address<= i;
				wren<= 1;
				done_flag<=0;
				data<= data_j;
				
				state<= write_j;
			
			
			end
			
			write_j: begin
			
				address<= j;
				wren<= 1;
				done_flag<=0;
				data<= data_i;
				
				state<= inc_i;
			
			
			end
			
			inc_i: begin
				
				done_flag<=0;
				i<=i+1;
			
			end
			
			
			finish: begin
			
			state<=finish 
			done_flag<= 1;
			
			end
			
		
		endcase
	end

end



endmodule