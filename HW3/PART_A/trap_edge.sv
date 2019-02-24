module trap_edge(
input logic clk,
input logic async_sig,
input logic reset,
output logic trapped_edge
);


logic high_edge;


sync sync1(
.clk(clk),
.async_sig(async_sig),
.high_edge(high_edge)
);

mux mux1(
.signal_in(high_edge),
.reset(reset),
.signal_out(trapped_edge)
);



endmodule 