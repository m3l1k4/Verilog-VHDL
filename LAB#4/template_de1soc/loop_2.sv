module loop_2(input logic clk, input logic rst_n,
           input logic en, output logic rdy,
           input logic [23:0] key,
           output logic [7:0] addr, input logic [7:0] rddata, output logic [7:0] wrdata, output logic wren);
		   
		   
		   
integer i = 0;
integer j = 0;
integer n = 0;

reg [7:0] rdata_i;
reg [7:0] rdata_j;
reg [23:0] keyin;

//parameter keylength = 3;

enum { wait_i,wait_i2, wait_j, wait_j2,calcj,save_i, save_j,read_i, read_j, write_j, write_i, done } state;

always_ff @(posedge clk, negedge rst_n) begin

if (rst_n == 0 )  begin
 i = 0;
 rdy = 0; 
 wren = 0; 
 state<=read_i;
 end

else if ( en == 1) begin

case (state)
 

read_i: begin


			if ( i < 256) begin // change to 256 before simulation

					n <= i%3;
					addr <= i ;
					rdy <= 0;
					wren <= 0; 
				state <= wait_i;	 
			end

			else
			state<= done;
 


end

wait_i: begin

state<=wait_i2;

end

wait_i2: begin

state<=save_i;

end

save_i: begin


if ( n == 0 )  keyin = key[23:16];
else if (n==1) keyin = key[15:8];
else keyin = key[7:0] ;

rdata_i<= rddata;
j <= (j + rddata + keyin) % 256 ;
state<=read_j;


//state<=done;

end

read_j: begin

addr <= j ;
rdy <= 0;
wren <= 0; 
state <= wait_j;

end


wait_j: begin

state<=wait_j2;

end


wait_j2: begin

state<=save_j;

end

save_j: begin

rdata_j<=rddata;
state<=write_i;

end

write_i: begin

wren<=1;
addr<=j;
wrdata<=rdata_i;
state<= write_j;

end

write_j: begin

wren<=1;
addr<=i;
wrdata<=rdata_j;
state<=read_i;
i<=i+1;

end


done: begin
addr<=0;
rdy<= 1;
wren<= 0;
end



endcase 
end
end
endmodule
