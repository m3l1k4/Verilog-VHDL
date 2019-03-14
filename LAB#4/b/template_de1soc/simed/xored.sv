module xored();

reg [7:0] a; 
reg [7:0] b;
reg [7:0] c;

assign a = 8'b10010100;
assign b = 8'b10110110;
initial begin

c = a ^ b;

end


endmodule 