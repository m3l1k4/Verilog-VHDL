module abs_val_tb();


reg [7:0] data_in_tb;
wire [7:0] data_out_tb;

abs_val tes (
.data_in(data_in_tb), 
.data_out(data_out_tb)

);



initial begin

data_in_tb=8'b00001000; //8
#2;
data_in_tb = 8'b11111011; //-5
#2;



end


endmodule 