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

   
wire  two_done,LOOP_1_done, loop_3_done,
		wren, wren1, wren2, wren3,
		wren_dm;
wire [7:0] addr, addr_one, addr_two, addr_3, addr_dm, addr_em;
wire [7:0] data_to_mem, data1, data2, data3, data_dm;
wire [7:0] q, q_em, q_dm;


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
	
	
muxdata one_two_sel( .wren_1(wren1), .wren_2(wren2), .wren_3(wren3),
				.data_in_one(data1), .data_in_two(data2), .data_in_three(data3),
				.addr_one(addr_one), .addr_two(addr_two), .addr_three(addr_3),
				.clk(CLOCK_50), .LOOP_1_done(LOOP_1_done),  .loop_2_done(two_done),
				.data(data_to_mem), .address(addr), .wren(wren) );
				
				
////////////////////////////////////////////////////////////////


loop_3 third(
.clk(CLOCK_50),
.reset(KEY[3]),
.start_flag(two_done),
.done_flag(loop_3_done),

// for S memory
.addr(addr_3), 
.rddata(q), 
.wrdata(data3),
.wren(wren3),

// for EM memory   
.addr_enc(addr_em), 
.rddata_enc(q_em), 
		   
// for DM memory 
	   
.addr_dec(addr_dm), 
.rddata_dec(q_dm), 
.wrdata_dec(data_dm),
.wren_dec(wren_dm)
		   
);				
				

	
//////////////////////////////////////////////////////////	
	
   s_memory S( .address(addr), 
			   .clock(CLOCK_50), 
			   .data(data_to_mem), 
			   .wren(wren), 
			   .q(q) );
			   
   EM_memory EM(
	.address(addr_em),
	.clock(CLOCK_50),
	.q(q_em));
	
   DM DM(
	.address(addr_dm),
	.clock(CLOCK_50),
	.data(data_dm),
	.wren(wren_dm),
	.q(q_dm));
		   
			   
	 



endmodule 