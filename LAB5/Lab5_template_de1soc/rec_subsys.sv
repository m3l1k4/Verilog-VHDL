module rec_subsys(

input logic en_level,
input logic clk_receive,
input logic reset,
output logic out_edge


);


logic en_strobe, q_to_d, to_xor;

FDC first_dff( .D(en_level), .Q(q_to_d), .C(clk_receive), .clr(reset));
FDC second_dff (.D(q_to_d), .Q(en_strobe), .C(clk_receive), .clr(reset));

FDC third_dff (.D(en_strobe), .Q(to_xor), .C(clk_receive), .clr(reset));

assign out_edge = to_xor ^ en_strobe;


endmodule