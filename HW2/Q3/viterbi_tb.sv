module viterbi_tb();

reg clk_tb, reset_tb;
reg [7:0] in_data_tb;
reg[2:0] in_addr_tb;
reg is_write_tb;
reg start_tb;
reg vit_num_tb;

wire vit1_cs_tb;
wire vit2_cs_tb;
wire[2:0] out_addr_tb;

wire[7:0] vit_data_tb;
wire out_RD_tb,out_WR_tb,finish_tb;
wire[7:0] return_data_tb;






viterbi_ctrl vit_tb(.clk(clk_tb),
.reset_all(reset_tb),
.in_addr(in_addr_tb),
.in_data(in_data_tb),
.is_write(is_write_tb),
.start(start_tb),
.vit_num(vit_num_tb),
.vit1_cs(vit1_cs_tb),
.vit2_cs(vit2_cs_tb),
.out_addr(out_addr_tb),
.vit_data(vit_data_tb),
.out_RD(out_RD_tb),
.out_WR(out_WR_tb),
.return_data(return_data_tb),
.finish(finish_tb)
);

initial forever begin

clk_tb=0;
#1;
clk_tb = 1;
#1;

end

initial begin

reset_tb = 1; 
#2;
reset_tb = 0;
#2;
reset_tb = 1; 
#3;

in_data_tb = 8'b01010101;
in_addr_tb = 3'b001;
vit_num_tb = 0;
start_tb = 1;
is_write_tb = 1;
#3;
start_tb = 1;
is_write_tb = 0;
#3;




end




endmodule