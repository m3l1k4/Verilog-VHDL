module test_statement (


input clk, input reset,
input A

);

logic b,c,d;

enum{state_1, state_2,state_3, state_4} state;


always_ff@(posedge clk, negedge reset) begin

if (~reset) begin

b<=0;
c<=0;
d<=0;

state<= state_1;

end

else begin 

case(state)


state_1: begin
		b<=1;
		c<=0; 
		d<=1;
state<=state_2;


		
		
end


state_2: begin



		b<=0;
		c<=1; 
		d<=0;
if(A)   begin

		state<= state_4;

end

else  begin


		
		state<= state_3;
end

end


state_3: begin

		b<=1;
		c<=1; 
		d<=1;
		
		state<= state_3;
		
		end

		
state_4 : begin

		b<=1;
		c<=1; 
		d<=0;

state<= state_2;
end

endcase




end
end


endmodule 