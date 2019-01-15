module LED_CONT( LEDS, clk);


input clk; // clock_50
output [7:0] LEDS;

logic [31:0] count;

enum { start,LEDS0, LEDS1,LEDS2,LEDS3,LEDS4,LEDS5,LEDS6,LEDS7,LEDS8} state;


always @(posedge clk) begin




case(state)


start: begin

LEDS [7:0] <= 0 ;
count<= 0;

end


LEDS0: begin

	if ( count >= 25000000 ) begin
		count <= 0;
		LEDS[0]<= 0;
		state<=LEDS1;  end
		
	else begin
	count<= count +1;
	LEDS[0] <= 1;
	state<= LEDS0;
	end

end


LEDS1: begin 

if ( count >= 25000000 ) begin
		count <= 0;
		LEDS[1]<= 0;
		state<=LEDS2; end
		
	else begin
	count<= count +1;
	LEDS[1] <= 1;
	state<= LEDS1;
	end


end

LEDS2: begin 

if ( count >= 25000000 ) begin
		count <= 0;
		LEDS[2]<= 0;
		state<=LEDS3; end
		
	else begin
	count<= count +1;
	LEDS[2] <= 1;
	state<= LEDS2;
	end


end


LEDS3: begin

if ( count >= 25000000 ) begin
		count <= 0;
		LEDS[3]<= 0;
		state<=LEDS4; end
		
	else begin
	count<= count +1;
	LEDS[3] <= 1;
	state<= LEDS3;
	end



end

LEDS4: begin

if ( count >= 25000000 ) begin
		count <= 0;
		LEDS[4]<= 0;
		state<=LEDS5; end
	else begin
	count<= count +1;
	LEDS[4] <= 1;
	state<= LEDS4;
	end



end

LEDS5: begin


if ( count >= 25000000 ) begin
		count <= 0;
		LEDS[5]<= 0;
		state<=LEDS6; end
		
	else begin
	count<= count +1;
	LEDS[5] <= 1;
	state<= LEDS5;
	end



end

LEDS6: begin

if ( count >= 25000000 ) begin
		count <= 0;
		LEDS[6]<= 0;
		state<=LEDS7; end
		
	else begin
	count<= count +1;
	LEDS[6] <= 1;
	state<= LEDS6;
	end



end

LEDS7: begin

if ( count >= 25000000 ) begin
		count <= 0;
		LEDS[7]<= 0;
		state<=LEDS0; end
		
	else begin
	count<= count +1;
	LEDS[7] <= 1;
	state<= LEDS7;
	end


end


default: state<= start;

endcase
end 



endmodule