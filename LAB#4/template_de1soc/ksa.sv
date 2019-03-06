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

// for i = 0 to 255 { s[i] = i; }




wire  wren;
wire [7:0] addr;
wire [7:0] data_to_mem;
wire [7:0] q;

/*
first_loop first(

.clk(clk),
.reset_n(reset_n),
.address(addr),
.data(data),
.wren(wren)

);

*/

second_loop second(

.clk(clk),
.reset_n(reset_n),
.address(addr),
.data(data_to_mem), //output to mem
.data_read(q), // data from mem
.wren(wren),  // write enable output 
. keys(24'b00000000 00000010 01001001),  // secret key 





);




s_memory S(
	.address(addr),
	.clock(clk),
	.data(data_to_mem),
	.wren(wren),
	.q(q));




endmodule 