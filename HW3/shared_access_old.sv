module shared_access_to_one_state_machine 
#(
parameter N = 32;
parameter M = 8;

)

( 
output reg [(N-1):0] output_arguments,
output start_target_state_machine,
input target_state_machine_finished,
input sm_clk,
input logic start_request_a,
input logic start_request_b,
output logic finish_a,
output logic finish_b,
output logic reset_start_request_a,
output logic reset_start_request_b,
input [(N-1):0] input_argumnets_a,
input [(N-1):0] input_argumnets_b,
output reg [(M-1):0] received_data_a,
output reg [(M-1):0] received_data_b,
input reset,
input [M-1:0] in_received_data
);

logic register_data_a_enable;
logic register_data_b_enable;
logic select_b_output_parameters;

output_arguments = (select_b_output_parameters)? (input_argumnets_b): (input_argumnets_a);

received_data_a = ( register_data_a_enable? in_received_data: 0 )
received_data_b = ( register_data_b_enable? in_received_data: 0 ) 


enum {check_start_a, give_start_a, wait_for_finish_a, register_data_a, give_finish_a
	  check_start_b, give_start_b, wait_for_finish_b, register_data_b, give_finish_b} state;


always_ff( posedge sm_clk, posedge reset) begin

	if ( reset) begin


	end

	else begin

		case(state)
				
			check_start_a: begin
				
				if ( start_request_a) begin
				
					select_b_output_parameters<=0;
					start_target_state_machine<=0; //
					reset_start_request_a<=0; //
					reset_start_request_b<=0; //
					finish_a<=0; //
					finish_b<=0; //
					register_data_a_enable<=0;
					register_data_b_enable<=0;
					
					state<= give_start_a;
				
				end
				
				else begin
				
				state<= check_start_b;
				
				
				end
			
			end
			
			
			give_start_a: begin
					
					select_b_output_parameters<=0;
					start_target_state_machine<=1; //
					reset_start_request_a<=1; //
					reset_start_request_b<=0; //
					finish_a<=0; //
					finish_b<=0; //
					register_data_a_enable<=0;
					register_data_b_enable<=0;
				
					state<= wait_for_finish_a;
			
			end
			
			wait_for_finish_a: begin
			
				if ( target_state_machine_finished) begin
				
					select_b_output_parameters<=0;
					start_target_state_machine<=0; //
					reset_start_request_a<=0; //
					reset_start_request_b<=0; //
					finish_a<=0; //
					finish_b<=0; //
					register_data_a_enable<=0;
					register_data_b_enable<=0;
				
					state<= register_data_a;
				
				end
				
				else 
				state<= wait_for_finish_a;
			
			
			end
			
			register_data_a: begin
			
					select_b_output_parameters<=0;
					start_target_state_machine<=0; //
					reset_start_request_a<=0; //
					reset_start_request_b<=0; //
					finish_a<=0; //
					finish_b<=0; //
					register_data_a_enable<=1;
					register_data_b_enable<=0;
				
					state<= give_finish_a;		
			
			end
			
			give_finish_a: begin
			
					select_b_output_parameters<=0;
					start_target_state_machine<=0; //
					reset_start_request_a<=0; //
					reset_start_request_b<=0; //
					finish_a<=1; //
					finish_b<=0; //
					register_data_a_enable<=0;
					register_data_b_enable<=0;
				
					state<= check_start_b;	
			
			
			end
			
			check_start_b: begin
				
				if ( start_request_b) begin
				
					select_b_output_parameters<=1;
					start_target_state_machine<=0; //
					reset_start_request_a<=0; //
					reset_start_request_b<=0; //
					finish_a<=0; //
					finish_b<=0; //
					register_data_a_enable<=0;
					register_data_b_enable<=0;
				
					state<= check_start_b;	
				end	

				else
				
				state<= check_start_a;
			
			
			
			end
			
			give_start_b: begin

					select_b_output_parameters<=1;
					start_target_state_machine<=1; //
					reset_start_request_a<=0; //
					reset_start_request_b<=1; //
					finish_a<=0; //
					finish_b<=0; //
					register_data_a_enable<=0;
					register_data_b_enable<=0;
				
					state<= wait_for_finish_b;			
			
			
			end
			
			wait_for_finish_b: begin
			
					if(target_state_machine_finished) begin

					select_b_output_parameters<=1;
					start_target_state_machine<=0; //
					reset_start_request_a<=0; //
					reset_start_request_b<=0; //
					finish_a<=0; //
					finish_b<=0; //
					register_data_a_enable<=0;
					register_data_b_enable<=0;
				
					state<= register_data_b;			
								
					
					
					end
					
					else
					state<= wait_for_finish_b;
			
			
			end
			
			register_data_b: begin

					select_b_output_parameters<=1;
					start_target_state_machine<=0; //
					reset_start_request_a<=0; //
					reset_start_request_b<=0; //
					finish_a<=0; //
					finish_b<=0; //
					register_data_a_enable<=0;
					register_data_b_enable<=1;
				
					state<= give_finish_b;
			
			
			end
			
			give_finish_b:begin
			
					select_b_output_parameters<=1;
					start_target_state_machine<=0; //
					reset_start_request_a<=0; //
					reset_start_request_b<=0; //
					finish_a<=0; //
					finish_b<=1; //
					register_data_a_enable<=0;
					register_data_b_enable<=0;
				
					state<= check_start_a;
			
			
			
			
			end
			
			
			
			
		endcase 
	default: state<=check_start_a; // add default case
	end
end




endmodule