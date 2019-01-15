module LED_CONT ( LED, clk)


input clk; // clock_50
output [7:0] LED;

logic [31:0] count;

enum { start, finish , LED1,LED2,LED3,LED4,LED5,LED6,LED7,LED8} states;


always @(posedge clk) begin




case(state)


LED0: begin

	if ( count >= 25000000 )
		count <= 0;
		LED[0]<= 0;
		state<=LED1;
		
	else begin
	count<= count +1;
	LED[0] <= 1;
	state<= LED0;
	end

end


LED1: begin 

if ( count >= 25000000 )
		count <= 0;
		LED[1]<= 0;
		state<=LED2;
		
	else begin
	count<= count +1;
	LED[1] <= 1;
	state<= LED1;
	end


end

LED2: begin 

if ( count >= 25000000 )
		count <= 0;
		LED[2]<= 0;
		state<=LED3;
		
	else begin
	count<= count +1;
	LED[2] <= 1;
	state<= LED2;
	end


end


LED3: begin





end

LED4: begin

end

LED5: begin

end

LED6: begin


end

LED7: begin

end

LED8: begin

end

default: state<= start ;


end 



endmodule