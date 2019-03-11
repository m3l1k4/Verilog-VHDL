module muxdata( 

input logic wren_1, 
input logic wren_2, 
input logic wren_3,
input logic [7:0] data_in_one, 
input logic [7:0] data_in_two, 
input logic [7:0] data_in_three,
input logic [7:0] addr_one, 
input logic [7:0] addr_two, 
input logic [7:0] addr_three,

input clk, 
input LOOP_1_done ,
input loop_2_done,
input loop_3_done,


 output logic [7:0] data,
 output logic [7:0] address, 
 output logic wren,);


always@(posedge clk) begin

if ( LOOP_1_done == 0 ) begin

data = data_in_one ;
address = addr_one; 
wren = wren_1;
end

else if ( LOOP_1_done == 1) begin

data = data_in_two ; 
address = addr_two;
wren = wren_2;
end


else if ( loop_2_done == 1) begin

data= data_in_three;
address = addr_three;
wren = wren_3;

end

end

 

endmodule: muxdata