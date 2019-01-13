`timescale 1ns / 1ps
module Generate_Arbitrary_Divided_Clk32(inclk,outclk,outclk_Not,div_clk_count,Reset);
    input inclk;
	 input Reset;
    output reg outclk;
	 output outclk_Not;
	 input[31:0] div_clk_count;
	 
	 var_clk_div32 Div_Clk(.inclk(inclk),.outclk(outclk),
	 .outclk_not(outclk_Not),.clk_count(div_clk_count),.Reset(Reset));

	// outclk_not , is not used, as in left open without a signal going anywhere in the basic_organ_solution 
	 
	 logic [31:0] count;
	 
	 always @(posedge inclk) begin
	 
	 If(reset==0) begin
	 
		if (  count == div_clk_count) begin
				count = 0;
				outclk = outclk +1;  end
				
		else begin
		
		count = count +1 ;
		outclk
				
				
	 
	 
	 
	 end 
	 
endmodule
