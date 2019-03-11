module check_char();


parameter char_low = 97;
parameter char_high = 122;
parameter char_space = 32;

// assign i to k from the loop_3 module 

integer charc = char_low;
reg [31:0] char_corrct;

always_ff@() begin




case(state) 

		key_new: begin
		
		if ( key_new_passed)  begin

		
			char_corrct<= 0;
			correct_key<=0;
			charc<= 97;
			request_next_key<= 0;
			
				
				state<= comp_char;
		
		end
		
		else state<= key_new;
		
		
		end

		comp_char: begin
		
			if ( i < 32 ) begin
			
				i<=i+1;
				
				charc<= 97;
				char_corrct<= char_correct +0;
				correct_key<=0;
				request_next_key<= 0;
				
				state<= check_range;
			
			
			end
			
			else state<= done;
		
		
		end
		
		
		check_range: begin
		
			if (charc<= char_high) begin
				
				if ( char_in == charc | char_in == char_space) begin
				
					char_corrct<= char_correct +1;
					charc<= charc +1;
					
					correct_key<=0;
					request_next_key<= 0;
					
					state<= comp_char;
					
				end
			
				else begin

					request_next_key<= 1;
					state<= key_new;
				end
				
			end
		
		
			else begin
			
				range_done<=1;
				
					if ( char_corrct == 32) begin
						
						correct_key<=1;
						request_next_key<=0;
						state<= found_key;
					end
					
					else begin
					
						correct_key<= 0;
						request_next_key<= 1;
						state<= key_new;
					
					end
					
			
			end
		
		
		end
		
		
		found_key: begin
		
		
		
		end
	


endcase


	


end

end


endmodule 