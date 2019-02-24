module sync(
input logic clk,
input logic async_sig,
output logic high_edge
);

logic n1;


always_ff@(posedge clk) begin

	n1<= async_sig;
	high_edge<= n1;

end

endmodule 

