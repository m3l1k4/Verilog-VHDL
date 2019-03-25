//`timescale 1ns / 1ps

module LFSR(
input Clock_1KHz,
input rst,
output logic [4:0] lfsr_out

);

wire out_0,out_1,out_2,out_3,out_4, feedback;


logic [4:0] lfsr;

assign lfsr = {out_4, out_3,out_2,out_1,out_0};
assign lfsr_out = lfsr;

FDC_init lfsr_3( .D(out_4), .Q(out_3), .C(Clock_1KHz), .clr(rst));
FDC lfsr_2( .D(out_3), .Q(out_2), .C(Clock_1KHz), .clr(rst));
FDC lfsr_1( .D(out_2), .Q(out_1), .C(Clock_1KHz), .clr(rst));
FDC lfsr_0( .D(out_1), .Q(out_0), .C(Clock_1KHz), .clr(rst));


xor_gate xored(.a(out_0), .b(out_2),.c(feedback));

FDC lfsr_4( .D(feedback), .Q(out_4), .C(Clock_1KHz), .clr(rst));



endmodule 