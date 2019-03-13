module loop_2(

			input logic clk,
			input logic rst_n,
           input logic first_loop_done, 
		   output logic done_flag,
           input logic [23:0] key,
           output logic [7:0] addr, 
		   input logic [7:0] rddata, 
		   output logic [7:0] wrdata, 
		   output logic wren,
		   
		   input logic start_over
		   
		   );
		   
		   
		    
reg [15:0] i,j;
reg [2:0] n; 


reg [7:0] rdata_i;
reg [7:0] rdata_j;
reg [7:0] secret_key;

parameter keylength = 3;

enum { 
wait_i, wait_i_2, 
wait_j, wait_j_2,calcj,
save_i, save_j,
read_i, read_j, 
write_j, write_i,
 done } state;

always_ff @(posedge clk, negedge rst_n) begin

	if (rst_n == 0 )  begin
		 i <= 0;
		 j <= 0;
		 n <= 0;
		 done_flag <= 0; 
		 wren <= 0; 
		 state<=read_i;
	 end
	 
	 
	else if (start_over == 1) begin
	
		i <= 0;
		j <= 0;
		n <= 0;
		done_flag <= 0; 
		wren <= 0; 
		state<=read_i;
	
	end

	else if ( first_loop_done) begin

		case (state)
		 

			read_i: begin


						if ( i < 256) begin // change to 256 before simulation

								n <= i%3;
								addr <= i ;
								done_flag <= 0;
								wren <= 0; 
							state <= wait_i;	 
						end

						else
						state<= done;
	
			end
			
			// two cycle delay
			
			wait_i: begin state<=wait_i_2; end
			wait_i_2: begin 
			// calc secret while you're at it
			
				if ( n == 0 )  secret_key <= key[23:16];
				else if (n==1) secret_key <= key[15:8];
				else secret_key <= key[7:0] ; // n = 2
			
			
			state<=save_i; end

			save_i: begin




				rdata_i<= rddata;
				j <= (j + rddata + secret_key); //% 256 ;
				state<=read_j;

			end

			read_j: begin

				addr <= j ;
				done_flag <= 0;
				wren <= 0; 
				state <= wait_j;

			end

			// two cycle delay
			
			wait_j: begin state<=wait_j_2; end
			wait_j_2: begin state<=save_j; end

			save_j: begin

				rdata_j<=rddata;
				state<=write_i;

			end

			write_i: begin

				wren<=1;
				addr<=j;
				wrdata<=rdata_i;
				state<= write_j;

			end

			write_j: begin

				wren<=1;
				addr<=i;
				wrdata<=rdata_j;
				state<=read_i;
				i<=i+1;

			end


			done: begin
				addr<=0;
				done_flag<= 1;
				wren<= 0;
				state<=done;
			end



		endcase 
	end
	end
endmodule
