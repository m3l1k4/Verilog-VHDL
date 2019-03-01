module dir_tb();


reg direction_flag_tb;
reg clk_tb, rst_tb;
wire [5:0] addr_inc_tb;




test_dir test_dir(

.direction_flag(direction_flag_tb),
.addr_inc(addr_inc_tb),
 .clk(clk_tb),
 .rst(rst_tb)


);



initial forever begin
clk_tb=0;
#1;

clk_tb = 1;
#1;
end


initial begin

rst_tb=1;
#1;
rst_tb=0;
#1;
rst_tb=1;
#1;
rst_tb=0;
#1;
direction_flag_tb= 1;

#5;

direction_flag_tb = 0;

#6;

direction_flag_tb = 1;

#5;

direction_flag_tb = 0;

#5;



end


endmodule