//`timescale 1ns / 1ps
module Generate_Arbitrary_Divided_Clk32(inclk,outclk,outclk_Not,div_clk_count,Reset);
    input inclk;
	 input Reset;
    output reg outclk;
	 output outclk_Not;
	 input[31:0] div_clk_count; // gets values from the instantiation in basic_organ_solution

	 logic [31:0] count; // clock counter

	 enum {count_state} state;
	 
	 always @(posedge inclk, posedge Reset) begin
//	/*  // reset state if simulating with wave, not needed for live performance as reset is being fed a 1'b1
	 if (Reset==1) begin   
				count <= 0;
				outclk <= 0;
				state<=count_state;
	 end
	// */
	
		else begin
		
			case(state)
			 
			 
		count_state:begin

			if ( count >= div_clk_count) begin
					count <=0;
					outclk <= ~outclk;  // alternating between 0 and 1  
							  end
							
					else begin
					
					count <= count +1 ;
							end 
							
						
			state<=count_state;			
			end				
			
			endcase
		
		end
	 
	end 

endmodule 


/*
in 			out			factor	hex
50000000	22000		1136  	16'h470




*/



