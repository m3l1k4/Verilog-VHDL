module send_lfsr_to_vga(
input logic sync_signal,
input logic lfsr_0_bit_in,
output logic  lfsr_0_bit_out


);


always@(posedge sync_signal) begin

lfsr_0_bit_out<= lfsr_0_bit_in;

end


endmodule