module edge_detect( 

// receiveing sub ssytem

input logic clk_receive,
input logic reset,
output logic out_edge,
// sending subsys
input logic clk_send,
input logic en


);

logic en_level_sig	;	
		
sending_subsys  sending(
.en(en), // input
.reset(reset),
.clk_send(clk_send),
.en_level (en_level_sig) // wire

);

rec_subsys receving(

.en_level (en_level_sig),
.clk_receive(clk_receive),
.reset(reset),
.out_edge(out_edge)


);

		
		
endmodule
		

////////////////////////////////////////////////////


