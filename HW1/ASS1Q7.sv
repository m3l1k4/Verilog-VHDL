module Q7( input logic async_sig, 
		input logic outclk,
		output logic out_sync_sig,
		input logic VCC,
		input logic GND);

wire QA,QB,QC;
wire Q_1;

		
FDC A(.D(VCC),.Q(QA),.C(async_sig),.clr(Q_1));
FDC B(.D(QA),.Q(QB),.C(outclk),.clr(GND));
FDC C(.D(QB),.Q(out_sync_sig),.C(outclk),.clr(GND));
FDC FDC_1(.D(),.Q(Q_1),.C(outclk),.clr(GND));		
		
endmodule
		

////////////////////////////////////////////////////


module FDC( D, Q, C, clr);

input logic C, D, clr;  // D is in
output logic Q; // Q is out


always_ff@( posedge C, posedge clr) begin

if (clr) 
Q<=0;

else 

Q<=D;

end 


endmodule