module check_char(
input clok,
input resetm,
output reg [9:0] LEDS,
input logic new_char, // character flag from loop_3
output logic new_key,  // new key flag fed to loop 1
output logic start_over, // start over sets all 3 loops in init
output logic found_key, // found the key
output logic matched_cont, // character matched move on to next
input [7:0] char_recieved, // char from loop 3

input [5:0] char_count, // k in loop 3

output logic done,
output logic last_key,

output logic compared_char,
output reg [23:0] key//
);


reg [7:0] char_range; // range 97-122  , increments by 2
reg [7:0] char_range_counter; // 0 - 12 counter
 
logic flipped_key; 

parameter key_max =  24'b001111111111111111111111;


enum {
wait_for_next_char,
check_char,
get_next_key, one_wait,
reached_last_char,
reached_last_key,
finished_string
} state;

 


always_ff@(posedge clok, negedge resetm) begin

	if (resetm == 0 ) begin

		start_over<=0 ; // start over
		found_key<= 0; // did not find a key 
		matched_cont<= 0; // its not a match
		new_key<= 0;
		char_range_counter<=97; 
		char_range<= 97; // reset char range 
		key<= 24'b00000000000000010000000;  // reset key  00000000 00000011 11111111
		LEDS<=0;
		done<= 0; 
		last_key <=0;
		flipped_key<=0;
		compared_char<=0;
		state<= wait_for_next_char;
	
	end

	else begin
		case(state) 
		
		wait_for_next_char: begin

				compared_char<=0;
				start_over<=0 ; 
				
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

			if ( (char_recieved >= 97 && char_recieved<= 122 ) || char_recieved == 32) begin  // comparing 2 at a time 


					
					start_over<=0 ; // don't start over
					found_key<= 0; // did not find a key yet
				
					
					compared_char<=1;
						
					state<= wait_for_next_char; // go and wait until you get next char 
					
				
					end
					
					else begin
					
					matched_cont<= 0; // its not a match
					compared_char<=0;
					
					state<=  reached_last_char; // compare against next char
					
					
					end

			
						
		end


		get_next_key: begin
		
			if ( key <= key_max) begin  
				
				key<=key+1; // increment key 
				new_key<= 1; // raise new key flag
				start_over<=1 ; // start over
				
				char_range<= 97 ; // reseting range and counter
					char_range_counter<= 97;
				
				
				compared_char<=1; // this is for testing only remove for real 
				
				state<= wait_for_next_char;
				end
				
			// adding for odd - even key issue
					
				
			else begin
				
				if ( flipped_key==0) begin
				
				key<=24'b00000000000000010000001;
				start_over<=1 ; // start over
				compared_char<=1;
				new_key<= 1; // raise new key flag
				flipped_key <= 1;
				LEDS[4]<=1;
				state<= one_wait;
				end
				
				else 
				
				state<= reached_last_key;
			end 
		end


		one_wait:  begin
		start_over<=1 ;
		state<= wait_for_next_char;
		
		end
		
	reached_last_char: begin


		
	start_over<=1 ; // start over
	LEDS[3] <=1;//found_key<= 0; // did not find a key 
	matched_cont<= 0; // its not a match
    char_range_counter<=97;
	char_range<= 97; // reset char range 
	state<= get_next_key; // request next key 	

		

	end


	reached_last_key: begin

	last_key <= 1; // assign led 8 to it
	LEDS[0]<=1;
	state<= reached_last_key;
	end

	finished_string: begin
	done<= 1;  // assign led 9 to it 
	LEDS[1]<=1;
	LEDS[3] <=0;
	state<= finished_string;

	end



		endcase


	


	end

end


endmodule 