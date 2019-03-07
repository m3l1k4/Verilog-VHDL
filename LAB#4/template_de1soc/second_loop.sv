module second_loop(

input logic clk,
input logic reset_n,
output logic [7:0] address,
output logic [7:0] data,
input logic [7:0] data_read,
output logic wren,
input logic [23:0] sec_key,

input logic start_flag,
output logic done_flag

);


enum { idle, read_i,
wait_i,
wait_i_2,
save_i,
get_key_k,
set_j,
read_j,
wait_j,
wait_j_2,
save_j,
write_i,
write_j,
inc_i,
finish } state; 

//assign keys[23:10] = 0

logic [23:0] i, j;
logic [2:0] k;

logic key_length;
assign key_length = 3;

reg [7:0] data_i, data_j, secret_key;


always_ff@(posedge clk) begin

	if(start_flag==0) begin
		
		i<=0;
		j<=0;
		wren<= 0;
		done_flag<=0;
		state<= idle;
	
	end

	
	else begin
		case(state) 
		
			idle: begin
					if(start_flag==0) state<= idle;
					else state<= read_i;
				end			
				
			read_i: begin
				
				if ( i<256) begin
				
					address<= i;
					wren<= 0;
					k<= i % key_length;
					done_flag<=0;
					state<= wait_i;
					
				
				end
				
				else 
				
					state<= finish;
				
			end
			
			
			wait_i: state<= wait_i_2;
			wait_i_2: state<= save_i;
			
			save_i: begin
			
			data_i<= data_read;
			
			state<= get_key_k;
			

			
			
			end
			
			
			get_key_k: begin
			
				if ( k == 0 ) 
				secret_key <= sec_key[23:16];
				
				
				else if (k == 1)
				
				secret_key <= sec_key[15:8];
				
				
				else if ( k == 2) 
				secret_key <= sec_key[7:0];
				
			state<= set_j;
			end
			
			
			
			set_j: begin
			
				j<= (j + data_i + secret_key);
				done_flag<=0;
				
				state<= read_j;
			
			end
			
			read_j: begin
			
				address<= j;
				wren<= 0;
				done_flag<=0;
				state<= wait_j;
			
			end
			
			wait_j: state<= wait_j_2;
			wait_j_2: state<= save_j;
			
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
				state<= read_i;
				
			end
			
			
			finish: begin
			
			state<=finish ;
			done_flag<= 1;
			
			end
			
		
		endcase
	end

end



endmodule