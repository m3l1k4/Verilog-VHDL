module HW2Q2_tb ();

reg restart_tb, pause_tb, goto_third_tb;
wire odd_tb, even_tb,terminal_tb;
wire [2:0] out1_tb, out2_tb;

HW2Q2 HW2Q2(.restart(restart_tb),.pause(pause_tb), .goto_third(goto_third_tb), 
.out1(out1_tb), .out2(out2_tb), .odd(odd_tb), .even(even_tb), .terminal(terminal_tb)) ;

initial begin
restart_tb = 1; pause_tb = 0; goto_third_tb = 0;
#1;

restart_tb = 0; pause_tb = 0; goto_third_tb = 0;
#1;

restart_tb = 0; pause_tb = 1; goto_third_tb = 0;
#1;

restart_tb = 0; pause_tb = 0; goto_third_tb = 0;
#1;

restart_tb = 0; pause_tb = 1; goto_third_tb = 0;
#1;

restart_tb = 0; pause_tb = 0; goto_third_tb = 0;
#1;

restart_tb = 0; pause_tb = 1; goto_third_tb = 0;
#1;

restart_tb = 0; pause_tb = 0; goto_third_tb = 0;
#1;

restart_tb = 0; pause_tb = 1; goto_third_tb = 0;
#1;

restart_tb = 1; pause_tb = 1; goto_third_tb = 1;
#1;

restart_tb = 1;pause_tb = 0; goto_third_tb = 1;
#1;

restart_tb = 0; pause_tb = 0; goto_third_tb = 0;
#1;

restart_tb = 0; pause_tb = 1; goto_third_tb = 0;
#1;

restart_tb = 0; pause_tb = 0; goto_third_tb = 0;
#1;

restart_tb = 0; pause_tb = 1; goto_third_tb = 0;
#1;

restart_tb = 0; pause_tb = 0; goto_third_tb = 0;
#1;

restart_tb = 0; pause_tb = 1; goto_third_tb = 0;
#1;

restart_tb = 0; pause_tb = 0; goto_third_tb = 0;
#1;

restart_tb = 0; pause_tb = 1; goto_third_tb = 0;
#1;
end
endmodule