module read_SM(clk, rst, waitrequest, read, readdata, 
readvalid, address,passdata);

input logic clk,rst, waitrequest, readvalid;
input logic [31:0] readdata;
output logic [31:0] passdata;
output logic [22:0] address; // can ignore bits 23 to 31
output logic read ;

reg [15:0] data_upper;
reg [15:0] data_lower;
logic [22:0] addr_inc;  // used to increment address

enum {assert_read_addr,
	  check_data_valid,
	  pass_data,
	  inc_address} state;

//you will read 32-bit data from each address, for even addresses the data is in bits 15 to 0, 
//for odd addresses in bits 31 to 16. My recollection
 //is that the other bits will not be zero but will be the sample either before or after the current address

//fms is on clock 50M
always @(posedge clk, negedge rst) begin

if (rst)begin

address<=0;
read<= 0;
addr_inc<=0;

state<= assert_read_addr;

end


else begin

	case(state)
		
		assert_read_addr: begin
		
			if ( waitrequest == 0 ) begin
			
			address<= addr_inc;  // pass address address location 
			read<= 1;  // assert read
			state<= check_data_valid;
			
			end
			
			
			else if (waitrequest ==1) begin
			
			state<= assert_read_addr;
			
			end
		
		end
		
		
		check_data_valid: begin
		
			if (readvalid == 1) begin
			
			data_lower <= readdata [15:0];
			data_upper<= readdata [31:16];
			
			
			state<= pass_data;
			end
			
			
			else begin
			
			state<= check_data_valid;
			
			end
		
		
		end
		
		
		pass_data: begin
		
			if ( addr_inc[0] == 1)  begin// address is odd 
		
				passdata<= data_upper; // odd addresses in bits 31 to 16.
				state<= inc_address;
				
		
			end 
		
			else if ( addr_inc[0] == 0 ) begin // address is even 
		
				passdata<= data_lower;  //data is in bits 15 to 0, 
				state<= inc_address;
		
			end
		
		end 
		
		inc_address: begin  // increment address 
		
			if (addr_inc>= 23'h7FFFF) begin
		
				addr_inc<=0;
				state<= assert_read_addr;
		
			end
		
			else begin
				addr_inc<= addr_inc + 1;
				state<= assert_read_addr;
				end
		end

		
default: state<= assert_read_addr;	
		
	endcase 

end



end

endmodule