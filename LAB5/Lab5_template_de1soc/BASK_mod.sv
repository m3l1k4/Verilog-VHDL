module BASK_mod(clk,rst,din,dout); 
input clk,rst;
//input carrier; 
input[11:0] din; 
output [11:0] dout; 
 
wire[11:0] dout; 
integer cnt = 0; 
//reg carrier; 
logic carrier_0;
 
always_ff @(posedge clk) begin   
if(rst)    
	 begin   
	 cnt<=2'b00;    
	// carrier<=0;     
	 end   
	 
 else if(cnt==1)      

	 begin            
	 cnt<=0;            
	 carrier_0<=1;//~carrier;        
	 end       
	 
 else        
	 begin          
	 cnt<=cnt+1;        
	 carrier_0<=0;      
	 end 
 end          
 
 assign dout={12{carrier_0}}*din; 
 
 
endmodule