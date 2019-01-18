 // HW#1 Question #5 
 module  test( in, out);
 
 input [7:0] in;
 
 output reg [2:0] out;
// reg [1:0] hold1,hold2;
 // out[0] = Y0 , out[1] = Y1 , out[2] = Y2

// assign out[1] = hold1[1] | hold1[0]| hold2[1] | hold2[0];

//assign out[1] = in[3] | in[2] | in[6] | in[7] ; 
//assign out[0] = (~( in[3] + in[1]* ~in[2])) | ( in[7] + in[5]* ~in[6]);

always @(*) begin

if ( in[4] == 1 | in[5] == 1 | in[6] == 1 |in[7] == 1) begin
out[0] =  ( in[7] + in[5]* ~in[6]);
out[2] = 1'b1;
out[1] = in[6] | in[7] ; end
else begin
out[0] = ( in[3] + in[1]* ~in[2]);
out[2] = 1'b0;
out[1] = in[3] | in[2] ;
 end
end  
 
 
 endmodule 