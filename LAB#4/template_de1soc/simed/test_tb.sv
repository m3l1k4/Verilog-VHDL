module test_tb();



reg clk, reset, A;

test_statement DUT(


.clk(clk),.reset(reset),
.A(A)

);


initial forever begin

clk <=1;
#1;
clk<=0;
#1;

end


initial begin
reset<=1;
#1;
reset<=0;
#1;
reset<=1;
#1;

A<=1;
#6;
A<=0;

end

endmodule
