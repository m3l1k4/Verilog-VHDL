//used it for viewing the speed signal given in the original code on signal tap

module check_speed_sig ( input up_down, 
						output [7:0] up_down_ch);



always_comb begin

if ( up_down == 1 ) // up is one // low is zero
up_down_ch = 8'h49;  //I

else if ( up_down == 0) //O
up_down_ch = 8'h4F;

else
up_down_ch = 8'h5A; //Z

end



endmodule 