module HW1Q7( input logic async_sig, // slowclock
		input logic outclk, // fast clock
		output logic out_sync_sig,
		input logic VCC,
		input logic GND);

wire QA,QB,QC;
wire Q_1;

		
FDC A(.D(VCC),.Q(QA),.C(async_sig),.clr(Q_1));
FDC B(.D(QA),.Q(QB),.C(outclk),.clr(GND));
FDC C(.D(QB),.Q(out_sync_sig),.C(outclk),.clr(GND));
FDC FDC_1(.D(out_sync_sig),.Q(Q_1),.C(outclk),.clr(GND));		
		
endmodule
		

////////////////////////////////////////////////////


