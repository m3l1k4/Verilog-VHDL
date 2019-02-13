module speed_control(
clk,
rst,
speed_up,
speed_down,
speed_norm,
speed_freq);

input clk, rst;
input speed_up, speed_down, speed_norm;
output reg [31:0] speed_freq;
reg [31:0] old_speed;




always_ff@(speed_up, speed_down, speed_norm) begin // check back

if ( rst) begin

speed_freq <= 16'h8E1 ;
old_speed<= 16'h8E1;

end


else begin 

	if (speed_up ) begin
	
		
		if (speed_freq >= 16'h470) begin // factor 1136 for 22k freq
			speed_freq<= speed_freq - 16'h64;  // increase by 100
			old_speed<= speed_freq; end
			
		else 
			speed_freq<=old_speed;
		
	end
	
	else if (speed_down) begin
	
			if ( speed_freq <= 16'h30D4) begin //factor 12500 , 2K frequency
			speed_freq<= speed_freq + 16'h64; // decrease by 100
			old_speed<= speed_freq;
			end
			
			else
			
			speed_freq<= old_speed;
		
	
	end
	
	
	else if ( speed_norm ) begin
			speed_freq<= 16'h8E1;
			old_speed<= speed_freq;
			end
			
	else
	speed_freq<= old_speed;

end

end
endmodule