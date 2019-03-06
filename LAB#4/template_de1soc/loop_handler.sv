module loop_handler (

input clok,
input rst,

input first_loop_done,
input second_loop_done,

output first_loop_start,
output second_loop_start



);




always_ff@(posedge clok, negedge rst) begin

if (!rst) begin

first_loop_start<=0;
second_loop_start<= 0;

end

else begin

case( state) 

	call_first_loop:   begin

		first_loop_start<=1;
		second_loop_start<= 0;
		state<= wait_first_loop_done;

	end

	
	wait_first_loop_done: begin
	
		if ( first_loop_done) begin
		
			first_loop_start<=1;
			second_loop_start<= 1;
			state<= wait_second_loop_done;
		end

		else 
			state<= wait_first_loop_done;

	end
	
	
	wait_second_loop_done: begin
		
		if( second_loop_done) begin
		
			first_loop_start<=1;
			second_loop_start<= 1;
			state<= done_done;
		
		
		end
	
		else
			state<=wait_second_loop_done;
	
	
	
	end
	
	
	done_done: state<= done_done;

endcase 


end





end




endmodule 