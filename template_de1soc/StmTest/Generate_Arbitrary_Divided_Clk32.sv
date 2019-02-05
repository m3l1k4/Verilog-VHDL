`timescale 1ns / 1ps
module Generate_Arbitrary_Divided_Clk32(inclk,outclk,outclk_Not,div_clk_count,Reset);
    input inclk;
	 input Reset;
    output reg outclk;
	 output outclk_Not;
	 input[31:0] div_clk_count; // gets values from the instantiation in basic_organ_solution
	/*  // original 
	 var_clk_div32 Div_Clk(.inclk(inclk),.outclk(outclk),
	 .outclk_not(outclk_Not),.clk_count(div_clk_count),.Reset(Reset));
*/

	// outclk_not , is not used, as in left open without a signal going anywhere in the basic_organ_solution 
	 // reset is hard coded signal with 1 in original basic_org_sol 
	 // the reset stage is hidden here, but used in the test bench 
	// /*
	 logic [31:0] count; // clock counter

	 
	 always @(posedge inclk) begin
	/*  // reset state if simulating with wave, not needed for live performance as reset is being fed a 1'b1
	 if (reset==0) begin   
				count <= 0;
				outclk <= 0;
	 end
	 */
	 
	 //else begin 
		if ( count >= div_clk_count) begin
		count <=0;
		outclk <= ~outclk;  // alternating between 0 and 1  
				  end
				
		else begin
		
		count <= count +1 ;
				end 
				
	 
//	 end
	 
	 end 
	// */ 
endmodule 


/*
in 			out			factor	hex
50000000	22000		1136  	16'h470




*/



