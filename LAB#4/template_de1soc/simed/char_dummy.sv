module char_dummy(
input clock, input reset,
output reg [23:0] num_out,
);

integer a,b;


always_ff@(posedge clk, negedge reset) begin

if (~reset) begin

a<= 94;
b<= 97;

dummy<= state_a;
end



else begin

case(dummy)

state_a: begin

a<= a +1;
num_out<=a;
state<= state_b

end


state_b: begin

b<=b+1;
num_out<= b;

state_a<=a;

end


endcase 



end


endmodule