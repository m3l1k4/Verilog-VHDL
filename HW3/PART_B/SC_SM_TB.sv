module SC_SM_TB();

parameter N = 32;
parameter M = 8;

wire [(N-1):0] output_arguments_tb;
wire start_target_current_state_machine_tb;

wire  finish_a_tb;
wire  finish_b_tb;
wire  reset_start_request_a_tb;
wire  reset_start_request_b_tb;
wire  [(M-1):0] received_data_a_tb;
wire  [(M-1):0] received_data_b_tb;

reg sm_clk_tb;

reg reset_tb;
reg target_current_state_machine_finished_tb;
reg  start_request_a_tb;
reg  start_request_b_tb;

reg [(N-1):0] input_argumnets_a_tb;
reg [(N-1):0] input_argumnets_b_tb;
reg [M-1:0] in_received_data_tb;

assign input_argumnets_a_tb = 5;
assign input_argumnets_b_tb = 3;
assign in_received_data_tb = 7;


shared_access_to_one_current_state_machine  smtb(

.output_arguments(output_arguments_tb),
.start_target_current_state_machine(start_target_current_state_machine_tb),
.target_current_state_machine_finished(target_current_state_machine_finished_tb),
.sm_clk(sm_clk_tb),
.start_request_a(start_request_a_tb),
.start_request_b(start_request_b_tb),
.finish_a(finish_a_tb),
.finish_b(finish_b_tb),
.reset_start_request_a(reset_start_request_a_tb),
.reset_start_request_b(received_data_b_tb),
.input_argumnets_a(input_argumnets_a_tb),
.input_argumnets_b(input_argumnets_b_tb),
.received_data_a(received_data_a_tb),
.received_data_b(received_data_b_tb),
.reset(reset_tb),
.in_received_data(in_received_data_tb)
);

initial forever begin //clock

sm_clk_tb = 0;
#1;
sm_clk_tb = 1;
#1;


end


initial begin
reset_tb = 0;
target_current_state_machine_finished_tb= 0;
start_request_a_tb = 1;
start_request_b_tb = 0;
#1;

reset_tb = 1;  
target_current_state_machine_finished_tb= 0;
start_request_a_tb = 1;
start_request_b_tb = 0;
#1;

reset_tb = 0;  
target_current_state_machine_finished_tb= 0;
start_request_a_tb = 1;
start_request_b_tb = 0;
#1;

reset_tb = 0;  
target_current_state_machine_finished_tb= 0;
start_request_a_tb = 1;
start_request_b_tb = 0;
#1;

reset_tb = 0;  
target_current_state_machine_finished_tb= 0;
start_request_a_tb = 1;
start_request_b_tb = 0;
#2;


reset_tb = 0;  
target_current_state_machine_finished_tb= 1;
start_request_a_tb = 1;
start_request_b_tb = 0;
#1;

reset_tb = 0;  
target_current_state_machine_finished_tb= 1;
start_request_a_tb = 0;
start_request_b_tb = 0;
#2;

////////////
reset_tb = 0;  
target_current_state_machine_finished_tb= 0;
start_request_a_tb = 0;
start_request_b_tb = 1;
#2;

reset_tb = 0;  
target_current_state_machine_finished_tb= 0;
start_request_a_tb = 0;
start_request_b_tb = 1;
#1;

reset_tb = 0;  
target_current_state_machine_finished_tb= 0;
start_request_a_tb = 0;
start_request_b_tb = 1;
#1;

reset_tb = 0;  
target_current_state_machine_finished_tb= 0;
start_request_a_tb = 0;
start_request_b_tb = 1;
#2;


reset_tb = 0;  
target_current_state_machine_finished_tb= 1;
start_request_a_tb = 0;
start_request_b_tb = 1;
#1;

reset_tb = 0;  
target_current_state_machine_finished_tb= 1;
start_request_a_tb = 0;
start_request_b_tb = 0;
#2;


end

endmodule