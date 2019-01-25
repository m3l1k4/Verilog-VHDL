//`timescale 1ns / 1ps
module clk32_tb();
 reg clk;
	
    
	// output outclk_Not;
	reg [31:0] div_clk_count_tb;
	reg rst;
wire outclk_tb;
Generate_Arbitrary_Divided_Clk32 Generate_Arbitrary_Divided_Clk32(.inclk(clk),.outclk(outclk_tb),.outclk_Not()
,.div_clk_count(div_clk_count_tb),.Reset(rst));
   



initial forever begin
clk = 0;
#1;
clk= 1;
#1;
end

initial begin
rst = 0 ;
#2;
rst = 1;
#2;
rst = 0 ;
#2;
rst = 1;
#2;

div_clk_count_tb = 5; 
#6;
div_clk_count_tb = 7;
#3;
div_clk_count_tb = 3;
#3;
div_clk_count_tb = 11;
#5;
div_clk_count_tb = 13;
#14;
end

endmodule




