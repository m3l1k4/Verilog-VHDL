module pass_to_audio(clock50, rstn, synced_sig,
 getdata, pass_data_audio, confirm_pass, key_control); 

//  we are trying to catch a 
//signal of the fast clock in the slow clock domain
// synchronizer is only used to kick start


input clock50, rstn, synced_sig;
input logic [15:0] getdata;
output logic [15:0] pass_data_audio;
input logic [7:0] key_control;
output logic confirm_pass;




		// 8'h23 D music stops
		//8'h24 E the music starts again
		


enum { check_sync_sig, start_passing} goto;
		

always_ff@(posedge clock50) begin // don't need to read on clock22 , edge deterctor is already doing the work, all we care about the is risigning edge of the ouput signla needs to be checked on each read

if ( rstn ) begin

goto<= check_sync_sig;

end

else begin
	case(goto)

	check_sync_sig: begin

			if( synced_sig ==1) begin // ta says  check high on every read
            
			confirm_pass<=0;
			goto<= start_passing;
			
			
			end

			else begin
			confirm_pass<=0;
			goto<= check_sync_sig;
			
			end

	end


	start_passing: begin
	
		if (key_control ==  8'h23) begin // D is pressed so music should stop
		confirm_pass<=0;
		goto<=start_passing; 
		
		end
		
		else if ( key_control == 8'h24) begin

			pass_data_audio<= getdata;
			confirm_pass<=1;
			goto<= check_sync_sig;
			end
		
		else begin
		confirm_pass<=0;
		goto<=start_passing; 
		
		end

	end


endcase 

end
end
		
endmodule