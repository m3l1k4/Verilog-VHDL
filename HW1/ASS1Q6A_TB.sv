module test_tb1();

// for reg with enable 
reg [7:0] in;
reg clk, en;
wire [7:0] out;

test test(.CLOCK_50(clk),.en(en),.in(in), .out(out)); // wave with en
//test test(.CLOCK_50(clk),.in(in), .out(out));  // wave without en

initial forever begin
clk = 1;
#1;
clk = 0;
#1;

end


initial begin
en = 0;
in = 3'b101;
#2;
en = 1;
in = 3'b101;
#3;
en = 0;
in = 3'b110;
#2;
en = 1;
//in = 3'b110;

end

endmodule