module key_search();

integer i;
integer key;

integer max_key = 24'b001111111111111111111111;



always@() begin


if ( key< max_key) begin


	key <= key +1 ;



end



endmodule