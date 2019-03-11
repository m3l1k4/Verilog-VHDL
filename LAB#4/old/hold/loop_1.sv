module loop_1(input logic clk, input logic rst_n,
            input logic en, output logic rdy,
            output logic [7:0] addr, output logic [7:0] wrdata, output logic wren);
// q is wrdata
			
// your code here

integer addr_inc = 0;

always_ff @(posedge clk, negedge rst_n) begin

if (rst_n == 0 ) begin
 i = 0;
 rdy = 0;
 wren = 0;
  
 end

 else begin
 
		if ( i < 256 ) begin // change to 256 before simulation
			rdy <= 0;
			addr <= i ;
			wrdata <= i;
			i <= i  + 1;
			wren <= 1;
			 
						end
 
		else  begin
			wren <= 0; 
			rdy <= 1; end 
 
end

end

endmodule
