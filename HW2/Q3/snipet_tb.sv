module snipet_tb();


reg vit_num_tbs, clk_tb;
reg[7:0] in_data_tbs;
reg is_write_tbs;
reg[2:0] in_addr_tbs;

reg vit1_code_tbs, vit2_code_tbs, vit_cs_allow_tbs;

wire vit1_cs_tbs;
wire vit2_cs_tbs;
wire[2:0] out_addr_tbs;
wire [7:0] vit_data_tbs; //inout


snipet test(
.vit_num(vit_num_tbs),
.in_data(in_data_tbs),
.is_write(is_write_tbs),
.in_addr(in_addr_tbs),
.vit1_cs(vit1_cs_tbs),
.vit2_cs(vit2_cs_tbs),
.out_addr(out_addr_tbs),
.vit_data(vit_data_tbs),
.clk(clk_tb),
.vit1_code(vit1_code_tbs),
.vit2_code(vit2_code_tbs),
.vit_cs_allow(vit_cs_allow_tbs)
);



initial forever begin

clk_tb = 0;
#1;
clk_tb = 1;
#1;

end

initial begin
in_data_tbs = 8'b10101011;
in_addr_tbs = 3'b010;
is_write_tbs = 0;
vit2_code_tbs= 1;
end

initial begin
vit_num_tbs = 0;
vit1_code_tbs= 0;
vit_cs_allow_tbs= 0;
#5;

vit_num_tbs =0 ;
vit1_code_tbs= 0;
vit_cs_allow_tbs= 1;
#5;

vit_num_tbs =0 ;
vit1_code_tbs= 1;
vit_cs_allow_tbs= 1;
#5;

vit_num_tbs =0 ;
vit1_code_tbs= 1;
vit_cs_allow_tbs= 0;
#5;

vit_num_tbs =1 ;
vit1_code_tbs= 1;
vit_cs_allow_tbs= 0;
#5;


vit_num_tbs =1 ;
vit1_code_tbs= 0;
vit_cs_allow_tbs= 1;
#5;


vit_num_tbs =1 ;
vit1_code_tbs= 1;
vit_cs_allow_tbs= 1;
#2;

// 000 001 011 010 110 111  101

end


endmodule 