module sync_tb();


reg clk_tb, d_tb, rstb;
wire q_tb;



trap_edge sync1(
.clk(clk_tb),
.async_sig(d_tb),
.trapped_edge(q_tb),
.reset(rstb)
);


initial forever begin
clk_tb = 0;
#2;
clk_tb = 1;
#2;
end


initial begin
rstb = 1;
#2;
rstb = 0;
#3;
d_tb = 0;
#4;
d_tb = 1;
#5;
d_tb = 1;
#2;
d_tb = 0;
#3;
d_tb = 1;
#3;
rstb = 1;
#1; 
rstb = 0;
#3;
d_tb = 0;
#5;
d_tb = 0;
#6;
rstb = 1;
#2;
d_tb = 1;
#1;
d_tb = 0;
#1;
rstb = 0;
#3;


end

endmodule 