module just_direction (input clk, 
input rst, output reg dirc_flag, input dirc);

reg old_dirc;

enum{init } state;

always_ff@(posedge clk) begin

if ( rst) begin

dirc_flag<= 1;
old_dirc<= 1;
state<= init;

end

else begin

case(state)

init: begin

			if ( dirc == 1) begin

			dirc_flag<= 1;
			old_dirc<= 1;
			state<=init;

			end


			else if ( dirc == 0) begin

			dirc_flag<= 0;
			old_dirc<=0;
			state<= init;

			end



end


endcase 



end


end



endmodule