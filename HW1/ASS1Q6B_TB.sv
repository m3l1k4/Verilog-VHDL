module test_tb1();





reg [8:0] in;
reg clk, reset;
wire [8:0] out;

test test(.CLOCK_50(clk),.in(in),. reset(reset), .out(out));


initial forever begin
clk = 1;
#1;
clk = 0;
#1;

end


initial begin

in = 3'b101;
reset = 0;
#2;

in = 3'b001;
reset = 1;

#3;

in = 3'b110;
reset = 1;
#2;

in = 3'b111;
reset = 0;

end

endmodule