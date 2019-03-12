module check_char(
input clok,
input resetm,

input logic new_char, // character flag from loop_3
output logic new_key,  // new key flag fed to loop 1
output logic start_over, // start over sets all 3 loops in init
output logic found_key, // found the key
output logic matched_cont, // character matched move on to next
input [7:0] char_recieved, // char from loop 3

input [5:0] char_count // k in loop 3

);


reg [7:0] char_range; // range 97-122  , increments by 2
reg [3:0] char_range_counter; // 0 - 12 counter
reg [23:0] key; // 

parameter key_max =  24'b001111111111111111111111;


enum {
wait_for_next_char,
check_char,
get_next_key,
reached_last_char,
reached_last_key,
finished_string
} state;




always_ff@() begin

	if () begin

	end

	else begin
		case(state) 
		
		wait_for_next_char: begin

			if ( char_count< 32) begin // char_count is wired to K in loop_3 directly 
			
					if (new_char) begin // loop 3 will raise new char flag once its done the xor
						
						new_key<= 0;
						state<= check_char; 
						
						end

					else 
					state<= wait_for_next_char;
			end
			
			else
			state<= finished_string;
		
		end


		check_char: begin

			if ( char_range_counter<= 12 ) begin  // comparing 2 at a time 

					if (   (char_recieved == char_range) 
						|| (char_recieved == ( char_range +1 ) )
						|| (char_recieved == ( char_range +2 ) )
						|| (char_recieved === 32 ) // char_space
					 
						
						) begin
					
					char_range<= char_range + 4 ; // moving along the 97-122 , doing four at a time because it is less cycles
					char_range_counter<= char_range_counter +1; // counting 0 - 30
					
					start_over<=0 ; // don't start over
					found_key<= 0; // did not find a key yet
				
					state<= wait_for_next_char; // go and wait until you get next char 
					
				
					end
					
					else begin
					
					matched_cont<= 0; // its not a match
					
					state<= check_char; // compare against next char
					
					
					end

			end
					

			else begin

			state<= reached_last_char; // went through all 97-122 and did not find a match

			end		
						
		end


		get_next_key: begin
		
			if ( key <= key_max) begin  
				
				key<=key+1; // increment key 
				new_key<= 1; // raise new key flag
				state<= wait_for_next_char;
				
			else
				
				state<= reached_last_key;
		
		end


	reached_last_char: begin

		start_over<=1 ; // start over
		found_key<= 0; // did not find a key 
		matched_cont<= 0; // its not a match
		char_count<= 0; // reset char count
		char_range<= 0; // reset char range 
		state<= get_next_key; // request next key 	

	end


	reached_last_key: begin

	LEDS[9] <= 1;

	end

	finished_string: begin
	LEDS[8]<= 1; 

	state<= finished_string;

	end



		endcase


	


	end

end


endmodule 