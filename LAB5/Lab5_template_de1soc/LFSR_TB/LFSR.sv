module LFSR(
input clk,
input rst,


);

wire out_0,out_1,out_2,out_3,out_4, feedback;





FDC lfsr_3( .D(out_4), .Q(out_3), .C(clk), .clr(rst));
FDC lfsr_2( .D(out_3), .Q(out_2), .C(clk), .clr());
FDC lfsr_1( .D(out_2), .Q(out_1), .C(clk), .clr());
FDC lfsr_0( .D(out_1), .Q(out_0), .C(clk), .clr());


xor_gate xored(.a(out_0), .b(out_2),.c(feedback));

FDC lfsr_4( .D(feedback), .Q(out_4), .C(clk), .clr());

endmodule