module num_gen(
input clked,
output logic [7:0] rand_num 

);


logic clk;
logic [7:0] counter; 





always_ff@( posedge clk) begin


	if ( counter <= 255 ) begin

	counter<= counter +1;

	end 
	
	else begin

	counter<= 0 ; 


	end

end


assign rand_num= counter;

endmodule 