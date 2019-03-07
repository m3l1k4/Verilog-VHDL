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
assign reset_n = SW[3];



SevenSegmentDisplayDecoder ssd(.ssOut(ssOut), .nIn(nIn));


///===========================================================

// for i = 0 to 255 { s[i] = i; }




wire  wren, wren1, wren2;
wire [7:0] addr, addr1,addr2;
wire [7:0] data_to_mem, data_to_mem_1, data_to_mem_2;
wire [7:0] q;

logic first_done, second_done, first_start, second_start;

loop_handler LH(

.clok(clk),
.rst(reset_n),

.first_loop_done(first_done),
.second_loop_done(second_done),

.first_loop_start(first_start),
.second_loop_start(second_start),
.light(light_sig)


);

wire [2:0] light_sig;

assign LEDR[2:0] = light_sig;


first_loop first(

.clk(clk),
.reset_n(reset_n),
.address(addr1),
.data(data_to_mem_1),
.wren(wren1),

.done_flag(first_done),
.start_flag(first_start)


);




second_loop second(

.clk(clk),
.reset_n(reset_n),
.address(addr2),
.data(data_to_mem_2), //input to mem
.data_read(q), // data from mem
.wren(wren2),  // write enable output 
.sec_key('h00033C),  // 24'b00000000_00000010_01001001secret key 585
.start_flag(second_start),
.done_flag(second_done)
);  

assign wren = (first_done? wren2 : wren1) ;
assign addr = ( first_done? addr2 : addr1);
assign data_to_mem = ( first_done? data_to_mem_2 : data_to_mem_1); // ( first_done? data_to_mem_2 : data_to_mem_1);


assign LEDR[4] = ( first_done ? 1 : 0 ) ; 
assign LEDR[5] = ( second_done? 1: 0 ) ;


s_memory S(
	.address(addr),
	.clock(clk),
	.data(data_to_mem),
	.wren(wren),
	.q(q));




endmodule 