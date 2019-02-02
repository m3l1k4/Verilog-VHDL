module read_SM(clk, rst, waitrequest, read, readdata, 
readvalid, address,passdata);

input logic clk,rst, waitrequest, readvalid;
input logic [16:0] readdata;
output logic [31:0] passdata;
output logic [22:0] address; // can ignore bits 23 to 31
output read ;

reg [15:0] data_upper;
reg [15:0] data_lower;

//you will read 32-bit data from each address, for even addresses the data is in bits 15 to 0, 
//for odd addresses in bits 31 to 16. My recollection
 //is that the other bits will not be zero but will be the sample either before or after the current address

//fms is on clock 50M
always @(posedge clk, negedge rst) begin

if (rst)begin

address<=0;
read<= 0;

state<= assert_read_addr;

end


else begin

	case(state)
		
		assert_read_addr: begin
		
			if ( waitrequest == 0 ) begin
			
			address<=    // add address location 
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
			
			state<= pass_lower;
			end
			
			
			else begin
			
			state<= check_data_valid;
			
			end
		
		
		end
		
		
		pass_lower: begin
		
		passdata<= data_lower;
		state<= pass_upper;
		
		
		end
		
		
		pass_upper: begin
		
		passdata<= passdata;
		state<= assert_read_addr;
		
		end
		


	endcase 

end



end

endmodule