module mux(
input logic signal_in,
input logic reset,
output logic signal_out
);

reg flag;


always@(*) begin

	if ( reset) begin

	flag <= 0;
	signal_out<= 0;

	end
	
	else begin

		if ( flag == 1 | signal_in == 1) begin

			signal_out <= 1;
			flag <= 1;

		end 
		
		else  begin
		
			signal_out <= 0;
			flag <= 0;
			
		end
		

	end





end




endmodule