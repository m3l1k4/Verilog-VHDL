module cracker_tb();

reg clock, reset;

wire [1:0] led_cracker_tb;

wire new_char_flag_tb;
wire start_over_flag_tb, 
	done_flag_tb,last_key_flag,compared_char_flag_tb;

wire [23:0] char_rec_tb;
wire [23:0] keyin_tb;
reg [5:0] char_count_tb;

reg start_flag_tb;

check_char cracker_tb(
.clok(clock),
.resetm(reset),
.LEDS(led_cracker_tb),
.new_char(new_char_flag_tb), // character flag from loop_3
.new_key(),  // new key flag fed to loop 1
.start_over(start_over_flag_tb), // start over sets all 3 loops in init
.found_key(), // found the key
.matched_cont(), // character matched move on to next
.char_recieved(char_rec_tb), // char from loop 3

.char_count(char_count_tb), // k in loop 3

.done(done_flag),
.last_key(last_key_flag),

.compared_char(compared_char_flag_tb), // tell loop three you've done the comparison

.key(keyin_tb)// 

);



loop_3 third_tb(
.clk(clock),
.reset(reset),
.start_flag(start_flag_tb),
.done_flag(loop_3_done),

// for S memory
.addr(), 
.rddata(), 
.wrdata(),
.wren(),

// for EM memory   
.addr_enc(), 
.rddata_enc(), 
		   
// for DM memory 
	   
.addr_dec(), 
.rddata_dec(), 
.wrdata_dec(),
.wren_dec(),

// for cracker
.k(), // new added for cracker interface
.new_char(new_char_flag_tb), // new added for cracker interface
.char_compare(compared_char_flag_tb), // cracker saying its done the comparison
		   
.data_xord(), // fed into char recieved in cracker
		   
.start_over(start_over_flag_tb)  // start over flag 	   
);		


char_dummy dum(
.clock(clock), 
.reset(reset),
.num_out(char_rec_tb), .new_char_request(compared_char_flag_tb)
);





initial forever begin 
clock<=1;
#1;
clock<=0;
#1;
end

initial begin
char_count_tb<=0;
reset<=1;
#2; 
reset<=0;
#1;
reset<=1;
#2;
start_flag_tb<=1;
end

initial begin
/*char_count_tb<=1;
char_rec_tb<= 95;
#55;
char_rec_tb<= 99;
char_count_tb<=5;
#4;
char_rec_tb<= 32;
char_count_tb<=8;
#4;
char_rec_tb<= 122;
char_count_tb<=9;
#4;
char_count_tb<=10;
char_rec_tb<= 95;
#4;
char_rec_tb<= 32;
char_count_tb<=13;
#4;
char_rec_tb<= 100;
char_count_tb<=15;
#4;

char_rec_tb<= 50;
char_count_tb<=15;
#4;
*/






end


endmodule 