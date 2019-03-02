module clok_25( input fifty_in, output reg CLK_25n) ;


    
    always @(posedge fifty_in)
    begin
         CLK_25n <= !CLK_25n;
    end


endmodule 