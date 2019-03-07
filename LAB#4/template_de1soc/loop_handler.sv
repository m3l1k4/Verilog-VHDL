module loop_handler (

input clok,
input rst,

input first_loop_done,
input second_loop_done,

output logic first_loop_start,
output logic second_loop_start,
output logic [2:0] light


);


enum {call_first_loop,
wait_first_loop_done, 
wait_second_loop_done, 
done_done} state;


always_ff@(posedge clok, posedge rst) begin

if (rst) begin

first_loop_start<=0;
second_loop_start<= 0;
light<= 3'b100;

end

else begin

case( state) 

	call_first_loop:   begin

		first_loop_start<=1;
		second_loop_start<= 0;
		state<= wait_first_loop_done;
		light<= 3'b001;

	end

	
	wait_first_loop_done: begin
	
		if ( first_loop_done) begin
		
			first_loop_start<=1;
			second_loop_start<= 1;
			state<= wait_second_loop_done;
			light<= 3'b010;
		end

		else begin
			state<= wait_first_loop_done;
			
			end
			
	end
	
	
	wait_second_loop_done: begin
		
		if( second_loop_done) begin
		
			first_loop_start<=1;
			second_loop_start<= 1;
			state<= done_done;
		light<= 3'b101;
		
		end
	
		else begin
			state<=wait_second_loop_done;
			light<= 3'b111;
	end
	
	
	end
	
	
	done_done: state<= done_done;

endcase 


end





end




endmodule 