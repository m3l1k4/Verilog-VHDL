module key_search();

integer i;
integer key;

integer max_key = 24'b001111111111111111111111;



always@() begin



if ( cont_search) begin  

	if ( key< max_key) begin


		key <= key +1 ;
		not_found<=0;
		search_done<=0;
		
	end
	
	else begin
	not_found<=1;
	search_done<=1;
	end

else  begin

search_done<= 1;
not_found<= 1;
		
end 

end



endmodule