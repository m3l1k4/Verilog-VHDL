module loop_3(
input logic clk,
input logic reset,
input logic start_flag,
//input logic [7:0] data_in,
//output logic [7:0] data_out,
output logic done_flag,

           output logic [7:0] addr, 
		   input logic [7:0] rddata, 
		   output logic [7:0] wrdata,
		   output logic wren,
		   
		   output logic [7:0] addr_enc, 
		   input logic [7:0] rddata_enc, 
		   
		   
		    output logic [7:0] addr_dec, 
		   input logic [7:0] rddata_dec, 
		   output logic [7:0] wrdata_dec,
		   output logic wren_dec,
		   
		   output reg [5:0] k, // new added for cracker interface
		   output logic new_char, // new added for cracker interface
		   input logic char_compare, // cracker saying its done the comparison
		   
		   output reg [7:0] data_xord,// fed into char recieved in cracker
		   
		   input logic start_over

); 




parameter msg_length = 32;
parameter k_max = 31 ;  // msg length - 1 


integer i,j,m;
//reg [5:0] k; // made into reg was integer 
reg [7:0] data_i;
reg [7:0] data_j;
reg [7:0] data_f;
reg [7:0] data_k;



enum{start_over_state, wait_for_start_flag,
calc_i,
get_s_i,

wait_i,
wait_i_2,
save_i,
read_j,
wait_j,
wait_j_2,
save_j,
write_i,
write_j,
calc_m,
read_m,
wait_m,
wait_m_2,
save_m,
get_k,
wait_k,
wait_k_2,
save_k,
f_xor_data_k, wait_for_compare,
write_dec_k,
done
} state;





always_ff @(posedge clk, negedge reset) begin

	if (reset == 0  )  begin
		 i <= 0;
		 j <= 0;
		 
		 k <= 0;
		 m<= 0;
		 done_flag <= 0; 
		 wren <= 0; 
		 wren_dec<=0;
		 
		 new_char<=0;
		 
		 state<=wait_for_start_flag;
	end
	
	
	else if (start_flag) begin
	
	
	case(state)
	
		
		start_over_state: begin
		
		
		 i <= 0;
		 j <= 0;
		 
		 k <= 0;
		 m<= 0;
		 done_flag <= 0; 
		 wren <= 0; 
		 wren_dec<=0;
		 
		 new_char<=0;
		 
		data_i<=0;
		data_j<=0;
		data_f<=0;
		data_k<=0;
		
		
		 state<= wait_for_start_flag;
		

		
		
		end
		
		
		wait_for_start_flag: begin
		
		if ( start_flag) state<= calc_i;
		else state<= wait_for_start_flag;
		
		end
	
	
		calc_i: begin
			
			if ( k< 32) begin  // for k = 0 to message_length-1
			
			i <=(i + 1)%256;  //i = (i+1) mod 256
			done_flag <= 0;
			
			wren <= 0; 
			wren_dec<= 0;
			
			new_char<=0;
			
			state<= get_s_i; 
			
			end
			
			else
			state<=done;
			
			
		end
	
	
		get_s_i: begin  //s[i]
			
			addr <= i ;
			done_flag <= 0;
			wren <= 0;
			wren_dec<= 0;
		
		state <= wait_i;
		
		end
	
	
		wait_i: begin state<=wait_i_2; end
		wait_i_2: begin  state<=save_i; end
		
		save_i: begin
		
			data_i<= rddata; //s[i]
			j<= (j + rddata) %256; //j = (j+s[i]) mod 256
		    state<=read_j;
			done_flag <= 0;
			
			end

		read_j: begin  //s[j]

			addr <= j ;
			done_flag <= 0;
			wren <= 0; 
			wren_dec<= 0;
			state <= wait_j;

			end
		
			wait_j: begin state<=wait_j_2; end
			wait_j_2: begin state<=save_j; end
		
		
		save_j: begin

			data_j<=rddata; //s[j]
			state<=write_i;

			end
		
		write_i: begin //swap values of s[i] and s[j]

				wren<=1;
				addr<=j;
				wrdata<=data_i;
				state<= write_j;

			end

		write_j: begin //swap values of s[i] and s[j]

				wren<=1;
				addr<=i;
				wrdata<=data_j;
				state<= calc_m;
			end

			
		calc_m: begin // m is f = s[m]
		
			m <=(data_i+data_j) %256; //s[ (s[i]+s[j]) mod 256 ]
			done_flag <= 0;
			wren <= 0;
			wren_dec<= 0;
			state<= read_m;
		
		end
		
		
		read_m: begin
		
			addr <= m ;
			done_flag <= 0;
			wren <= 0; 
			wren_dec<= 0;
			
			state<= wait_m;
		
		
		end
		
		
		wait_m: begin state<=wait_m_2; end
		wait_m_2: begin state<=save_m; end
		
		save_m: begin
		
			data_f<= rddata; //f = s[ (s[i]+s[j]) mod 256 ]
			addr_enc<= k; //encrypted_input[k]
			
			state<= wait_k;
		
		end
	
		//decrypted_output[k] = f xor encrypted_input[k]
		
		wait_k: begin state<=wait_k_2; end
		wait_k_2: begin state<=save_k; end
		
		save_k: begin
			data_k<= rddata_enc;  //encrypted_input[k]
			state<= f_xor_data_k;
			
		end
		
		f_xor_data_k: begin
		
			data_xord <= data_f ^ data_k; //f xor encrypted_input[k]
			state<= wait_for_compare;
			new_char<=1; 
			
		end
		
		wait_for_compare: begin
		
	 	
		
		if ( start_over) state<= start_over_state;
		
		else if ( char_compare) state<= write_dec_k;
		
		else state<=wait_for_compare;
		
		
		end
		
		
		
		write_dec_k: begin
				
			new_char<=0; 
			wrdata_dec<=data_xord;
			wren_dec<=1;
			addr_dec<=k;
			k <= k +1;
			
			state<= calc_i;  
			
		
		end
		
		
		done: begin
			
			addr<=0;
			addr_dec<=0;
			addr_enc<=0;
			done_flag<= 1;
			wren<= 0;
			wren_dec<= 0;
			
			if ( start_over)
			state<= start_over_state;
			else
			state<=done;
		
		
		
		end
		
	endcase
	end


end

endmodule 