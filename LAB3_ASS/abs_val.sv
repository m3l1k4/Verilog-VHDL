module abs_val (
data_in, 
data_out

);

input logic [7:0] data_in;
output logic [7:0] data_out;


always_comb begin

if ($signed(data_in)<0)
data_out = -$signed(data_in);

else

data_out = data_in;

end



endmodule 