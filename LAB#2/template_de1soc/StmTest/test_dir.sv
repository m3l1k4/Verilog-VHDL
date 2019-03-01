module test_dir(

input direction_flag,


input rst,
input clk,
output reg [5:0] addr_inc

);




always_ff@(posedge clk, posedge rst) begin

if (rst) begin

addr_inc<=0;

end

else begin 


if ( direction_flag == 1) begin   // play forward
		 
		
			if (addr_inc>= 10) begin
		
				addr_inc<=0;

		
			end
		
			else begin
				addr_inc<= addr_inc + 1;

				end


end

else if (direction_flag == 0)  begin   // play backward
		
		if (addr_inc == 0) begin
		
				addr_inc<=10;
		
			end
		
			else begin
				addr_inc<= addr_inc - 1;
			
				end
		
		
end
		
		
end
		
		
end // 



endmodule 