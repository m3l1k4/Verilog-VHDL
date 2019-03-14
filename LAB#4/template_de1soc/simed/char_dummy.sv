module char_dummy(
input clock, input reset,
output reg [23:0] num_out, input logic new_char_request
);

reg [23:0] a,b;


enum {state_a,state_b} dummy;

always_ff@(posedge clock, negedge reset) begin

if (reset==0) begin

a<= 94;
b<= 97;
num_out<= 98;

dummy<= state_a;
end



else begin

case(dummy)

	state_a: begin	
	
	if ( new_char_request) begin
	a<= a +1;
	num_out<=b; 
	dummy<= state_b; 
	end
	
	else dummy<= state_a;

	end


	state_b: begin

	
	if ( new_char_request) begin
	b<=b+1;
	num_out<= a;
	dummy<= state_a;
	end
	
	
		else 
	dummy<=state_b;

end


endcase 


end
end


endmodule