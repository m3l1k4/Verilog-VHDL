module pass_to_audio(clock22, rstn, synced_sig, getdata, pass_data_audio); 

//  we are trying to catch a 
//signal of the fast clock in the slow clock domain
// synchronizer is only used to kick start


input clock22, rstn, synced_sig;
input logic [15:0] getdata;
output logic [15:0] pass_data_audio;





		
		


enum { check_sync_sig, start_passing} goto;
		

always@(posedge clock22) begin

if ( rstn ) begin

goto<= check_sync_sig;

end

else begin
	case(goto)

	check_sync_sig: begin

			if( synced_sig ==1) 

			goto<= start_passing;


			else
			goto<= check_sync_sig;

	end


	start_passing: begin

			pass_data_audio<= getdata;
			goto<= start_passing;

	end


endcase 

end
end
		
endmodule