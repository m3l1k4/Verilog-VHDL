module read_SM(clk, rst, waitrequest, read, readdata, 
readvalid, address,passdata);

input logic clk,rst, waitrequest, readvalid;
input logic [16:0] readdata;
output logic [31:0] passdata;
output logic [22:0] address; // can ignore bits 23 to 31
output read ;

reg [15:0] data_upper;
reg [15:0] data_lower;


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