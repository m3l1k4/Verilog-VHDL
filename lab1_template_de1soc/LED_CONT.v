module LED_CONT ( LED, clk)


input clk; // clock_50
output [7:0] LED;

logic [31:0] count;

enum { start,LED0, LED1,LED2,LED3,LED4,LED5,LED6,LED7,LED8} states;


always @(posedge clk) begin




case(state)


start: begin

LED [7:0] <= 0 ;
count<= 0;

end


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

if ( count >= 25000000 )
		count <= 0;
		LED[3]<= 0;
		state<=LED4;
		
	else begin
	count<= count +1;
	LED[3] <= 1;
	state<= LED3;
	end



end

LED4: begin

if ( count >= 25000000 )
		count <= 0;
		LED[4]<= 0;
		state<=LED5;
		
	else begin
	count<= count +1;
	LED[4] <= 1;
	state<= LED4;
	end



end

LED5: begin


if ( count >= 25000000 )
		count <= 0;
		LED[5]<= 0;
		state<=LED6;
		
	else begin
	count<= count +1;
	LED[5] <= 1;
	state<= LED5;
	end



end

LED6: begin

if ( count >= 25000000 )
		count <= 0;
		LED[6]<= 0;
		state<=LED7;
		
	else begin
	count<= count +1;
	LED[6] <= 1;
	state<= LED6;
	end



end

LED7: begin

if ( count >= 25000000 )
		count <= 0;
		LED[7]<= 0;
		state<=LED0;
		
	else begin
	count<= count +1;
	LED[7] <= 1;
	state<= LED7;
	end


end


default: state<= start;


end 



endmodule