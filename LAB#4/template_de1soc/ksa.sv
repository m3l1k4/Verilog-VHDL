module ksa(input logic CLOCK_50, input logic [3:0] KEY, input logic [9:0] SW,
             output logic [6:0] HEX0, output logic [6:0] HEX1, output logic [6:0] HEX2,
             output logic [6:0] HEX3, output logic [6:0] HEX4, output logic [6:0] HEX5,
             output logic [9:0] LEDR);




    
wire  rdy_ksa,rdy_init,en_init, wren, wreninit, wrenksa;
wire [7:0] addr, initaddr, ksaaddr;
wire [7:0] datain, data1, data2;
wire [7:0] q;


wire [23:0] keyin;
assign keyin = 'h00033C;

 
	 
		 
	 		loop_1 tbinity(.clk(CLOCK_50), .rst_n(KEY[3]), 
		.en(en_init), .rdy(rdy_init), .addr(initaddr), .wrdata(data1), .wren(wreninit));
	
	loop_2 tbksay(.clk(CLOCK_50), .rst_n(KEY[3]), .en(rdy_init), .rdy(rdy_ksa), 
	.key(keyin), .rddata(q), .addr(ksaaddr), .wrdata(data2), .wren(wrenksa));
	
	
muxdata tbmuxed( .wreninit(wreninit), .wrenksa(wrenksa) , .initdata(data1), .ksadata(data2), 
				 .initaddr(initaddr), .ksaaddr(ksaaddr), 
				.clk(CLOCK_50), .rdy_init(rdy_init) , .data(datain), .address(addr), .wren(wren) );

	
//////////////////////////////////////////////////////////	
	
    s_mem tbs( .address(addr), .clock(CLOCK_50), .data(datain), .wren(wren), .q(q) );
	 
	 

	 
	 
	 // your code here

endmodule
