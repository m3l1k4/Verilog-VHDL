module LAB3 (

CLOCK_50,
LEDR,
data_in,
abs_data_out,





);

input                       CLOCK_50;
output          [17:0]      LEDR;


logic  [7:0] LED;
assign LEDR[7:0] = LED[7:0];


endmodule