module ksa (

//////////// CLOCK //////////
input                       CLOCK_50,

//////////// LED //////////
output           [9:0]      LEDR,

//////////// KEY //////////
input            [3:0]      KEY,

//////////// SW //////////
input            [9:0]      SW,

//////////// SEG7 //////////
output           [6:0]      HEX0,
output           [6:0]      HEX1,
output           [6:0]      HEX2,
output           [6:0]      HEX3,
output           [6:0]      HEX4,
output           [6:0]      HEX5

);

logic clk, reset_n;
logic [6:0] ssOut;
logic [3:0] nIn;

assign clk = CLOCK_50 ;
assign reset_n = KEY[3];



SevenSegmentDisplayDecoder ssd(.ssOut(ssOut), .nIn(nIn));


///===========================================================

   
wire  two_done,LOOP_1_done, wren, wren1, wren2;
wire [7:0] addr, addr_one, addr_two;
wire [7:0] data_to_mem, data1, data2;
wire [7:0] q;


wire [23:0] keyin;
assign keyin = 24'b000000000000001001001001;

 
	 
	 
first_loop  first(

.clk(clk),
.reset_n(KEY[3]),
.address(addr_one),
.data(data1),
.wren(wren1),
.done_flag(LOOP_1_done),
.start_flag()

); 
	 
	 
		 
	 //		loop_1 tbinity(.clk(CLOCK_50), .rst_n(KEY[3]), 
	//	.en(en_init), .rdy(LOOP_1_done), .addr(addr_one), .wrdata(data1), .wren(wren_1));
	
loop_2 second(
.clk(CLOCK_50), 
.rst_n(KEY[3]), 
.first_loop_done(LOOP_1_done), 
.done_flag(two_done), 
.key(keyin), 
.rddata(q), 
.addr(addr_two), 
.wrdata(data2), 
.wren(wren2));
	
	
muxdata one_two_sel( .wren_1(wren1), .wren_2(wren2), 
				.data_in_one(data1), .data_in_two(data2), 
				.addr_one(addr_one), .addr_two(addr_two), 
				.clk(CLOCK_50), .LOOP_1_done(LOOP_1_done), 
				.data(data_to_mem), .address(addr), .wren(wren) );

	
//////////////////////////////////////////////////////////	
	
   s_memory S( .address(addr), .clock(CLOCK_50), .data(data_to_mem), .wren(wren), .q(q) );
	 



endmodule 