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

integer i =0; 
integer j =0;
integer k =0;

parameter keylength = 3;

reg [7:0] data_i, data_j;
reg [23:0] secret_key;


always_ff@(posedge clk, negedge reset_n) begin

	if(reset_n==0) begin
		
		i<=0;
		j<=0;
		k<=0;
		wren<= 0;
		done_flag<=0;
		state<= read_i;
	
	end

	
	else if ( start_flag)  begin
		case(state) 
		
				
			read_i: begin
				
				if ( i<256) begin
				
					address<= i;
					wren<= 0;
					k<= i % keylength;
					done_flag<=0;
					state<= wait_i;
					
				
				end
				
				else 
				
					state<= finish;
				
			end
			
			
			wait_i: state<= wait_i_2;
			wait_i_2: state<= save_i;
			
			save_i: begin
			
				if ( k == 0 ) 
				secret_key <= sec_key[23:16];
				
				
				else if (k == 1)
				
				secret_key <= sec_key[15:8];
				
				
				else //if ( k == 2) 
				secret_key <= sec_key[7:0];
			
			
			
			data_i<= data_read;
			j<= (j + data_read + secret_key)%256;
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
				
				wren<= 1;
				address<= j;
				
				done_flag<=0;
				data<= data_i;
				
				state<= write_j;
			
			
			end
			
			write_j: begin
				
				wren<= 1;
				address<= i;
				
				done_flag<=0;
				data<= data_j;
				
				
				i<=i+1;
				state<= read_i;
			
			
			end
			
			
			
			finish: begin
			
			wren<=0;
			state<=finish ;
			done_flag<= 1;
			
			end
			
		
		endcase
	end

end



endmodule