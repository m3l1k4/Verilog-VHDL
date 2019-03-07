module mux_loop_handle( input logic first_done, input logic wren1, input logic wren2,
				input logic [7:0] data_in_1, input logic [7:0] data_in_2, 
				 input logic [7:0] addrs1, input logic [7:0] addrs2, 
				input clk, output logic [7:0] data, output logic [7:0] address, output logic wren );


always@(posedge clk) begin

if ( first_done == 0 ) begin

data = data_in_1 ;
address = addrs1; 
wren = wren1;
end

else if ( first_done == 1) begin

data = data_in_2 ; 
address = addrs2;
wren = wren2;
end

end

 

endmodule