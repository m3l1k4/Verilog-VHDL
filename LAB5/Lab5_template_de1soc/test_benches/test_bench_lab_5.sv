module test_bench_lab_5();


reg clk_tb, rst_tb;
wire [4:0] lf_out;
LFSR lfsr_tb(
.clk(clk_tb),
.rst(rst_tb),
.lfsr_out(lf_out)

);





initial forever begin

clk_tb = 1;
#1;
clk_tb = 0;
#1;

end

initial begin

rst_tb = 1;
#1;
rst_tb = 0;
#1;
rst_tb = 1;
#1;
rst_tb = 0;
#1;


end


endmodule