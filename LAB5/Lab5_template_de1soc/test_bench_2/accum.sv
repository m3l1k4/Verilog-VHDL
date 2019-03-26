module accum_saw(clk, out);
  input             clk;
  output reg [31:0] out = 0;  // assumes Verilog 2001
  
  always @ (posedge clk)
    out <= out + 1 * 64'h100000000 / 50;//1 ;//*64'h100000000; 
	//1/2 is square
	
	//170000 * 64'h100000000 / 50000000;  // 170 kHz output, 50 MHz clock
endmodule