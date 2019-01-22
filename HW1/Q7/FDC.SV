module FDC( D, Q, C, clr);

input logic C, D, clr;  // D is in // C is clock // clr is reset
output logic Q; // Q is out


always_ff@( posedge C, posedge clr) begin

if (clr) // if reset
Q<=0;  // out is zero

else 

Q<=D; // else out is in

end 


endmodule