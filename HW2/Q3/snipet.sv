module snipet(
vit_num,
in_data,
is_write,
in_addr,
vit1_cs,
vit2_cs,
out_addr,
vit_data,
clk,
vit1_code,
vit2_code,
vit_cs_allow
);

input vit_num, clk;
input[7:0] in_data;
input is_write;
input[2:0] in_addr;

output reg vit1_cs;
output reg vit2_cs;
output reg[2:0] out_addr;
output reg[7:0] vit_data; //inout

input vit1_code ;
input vit2_code ;

input vit_cs_allow; // s[3]
parameter allow_data_output = 1'b1; //s[5]



always @(posedge clk) begin

vit1_cs = !((vit_num == vit1_code) && (vit_cs_allow));
vit2_cs = !((vit_num == vit2_code) && (vit_cs_allow));
out_addr = in_addr;
vit_data = (allow_data_output && is_write) ? in_data[7:0] : 8'bz;

end 
endmodule 