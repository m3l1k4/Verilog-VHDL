module HW1Q7_TB();


reg async_sig_tb;
reg outclk_tb;
wire out_sync_sig_tb;
reg VCC_TB, GND_TB;


HW1Q7 HW1Q7TB( .async_sig(async_sig_tb), .outclk(outclk_tb),
		.out_sync_sig(out_sync_sig_tb),
		.VCC(VCC_TB), .GND(GND_TB));

		
initial forever begin
outclk_tb = 0;
#1;
outclk_tb = 1;
#1;

end
	
initial forever begin

async_sig_tb = 0;
#1;
async_sig_tb = 1;
#1;
	
end

initial begin

VCC_TB = 1;
GND_TB = 0;

end
	
endmodule