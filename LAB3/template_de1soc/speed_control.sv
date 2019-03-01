// for controlling speed

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

reg up_count, down_count;



always_ff@( speed_up, speed_down, speed_norm ) begin // check back

if ( rst) begin

speed_freq <= 16'h8E1 ;
old_speed<= 16'h8E1; // 11k //2273
up_count<= 0;
down_count<=0;

end


else begin 
// key1 will decrease the speed
	if (speed_down ) begin  //key1
			
		if ( down_count == 0) begin
			
			speed_freq<= 16'hBD6 ;  // 3030 for 8250 hz
			old_speed<= 16'hBD6 ;
			down_count<= down_count + 1;
			up_count<=0;
		
		end
		
			
			
		else if ( down_count == 1) begin
			
			speed_freq<= 16'h11C1;  // 4545 for 5500 hz
			old_speed<=  16'h11C1;
			down_count<= down_count + 1;
			up_count<=0;
		
		end
		
		
		else if ( down_count == 2) begin
		
			speed_freq<= 16'h17AD;   // 6061 for 4125 hz
			old_speed<= 16'h17AD;
			down_count<= down_count + 1;
			up_count<=0;
		
		end
		
		
		
		else if ( down_count == 3) begin
		
			speed_freq<= 16'h2383;   // 9091 for 2750 hz
			old_speed<= 16'h2383;
			down_count<= down_count + 1;
			up_count<=0;
		
		end
		
		else begin
		speed_freq<=old_speed;
		
		end
		
	end
	
	else if (speed_up) begin //key0

		if ( up_count == 0 ) begin
		
			speed_freq<= 16'h5EB ;  // 1515 for 16500 hz
			old_speed<=  16'h5EB ;
			up_count<= up_count + 1;
			down_count<=0;
		end


		else if ( up_count == 1 ) begin
		
			speed_freq<=  16'h470;  // 1136 for 22000 hz
			old_speed<=  16'h470;
			up_count<= up_count + 1;
			down_count<=0;
		end
		
		else if ( up_count == 2) begin
		
			speed_freq<= 16'h2F5;  // 757 for 33000 hz
			old_speed<= 16'h2F5;
			up_count<= up_count + 1;
			down_count<=0;
		
		end		


		else if ( up_count == 3) begin
		
			speed_freq<= 16'h238;  // 568 for 44000 hz
			old_speed<= 16'h238;
			up_count<= up_count + 1;
			down_count<=0;
		
		end
		
		else begin
		speed_freq<=old_speed;
		end
	
	end
	
	
	else if ( speed_norm ) begin
			speed_freq<= 16'h8E1;
			old_speed<= 16'h8E1;
			up_count<=0;
			down_count<=0;
			end
			
	else
	speed_freq<= old_speed;

end

end
endmodule