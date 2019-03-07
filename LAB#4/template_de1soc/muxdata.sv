module muxdata( input logic wreninit, input logic wrenksa, input logic [7:0] initdata, input logic [7:0] ksadata, 
				 input logic [7:0] initaddr, input logic [7:0] ksaaddr, 
				input clk, input rdy_init , output logic [7:0] data, output logic [7:0] address, output logic wren );


always@(posedge clk) begin

if ( rdy_init == 0 ) begin

data = initdata ;
address = initaddr; 
wren = wreninit;
end

else if ( rdy_init == 1) begin

data = ksadata ; 
address = ksaaddr;
wren = wrenksa;
end

end

 

endmodule: muxdata