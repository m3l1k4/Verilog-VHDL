module HW2Q1_tb();

reg pause_tb, restart_tb, clk_tb, rst_tb;
wire odd_tb, even_tb, terminal_tb;
wire [1:0] state_tb;





fsm fsm(.state(state_tb), .odd(odd_tb), .even(even_tb), .terminal(terminal_tb),
		.pause(pause_tb), .restart(restart_tb), .clk(clk_tb), .rst(rst_tb));
		

initial forever begin

clk_tb = 1;
#1;
clk_tb = 0;
#1;

end



initial begin
rst_tb = 0;
#1;
rst_tb = 1;
#1;
rst_tb = 0;
#1;


restart_tb = 0;
pause_tb = 1;
#1;
restart_tb = 1;
pause_tb = 1;
#1;
restart_tb = 0;
pause_tb = 0;
#1;



restart_tb = 0;
pause_tb = 1;
#1;
restart_tb = 1;
pause_tb = 1;
#1;
restart_tb = 0;
pause_tb = 0;
#1;
restart_tb = 0;
pause_tb = 0;
#1;

restart_tb = 0;
pause_tb = 1;
#1;

restart_tb = 0;
pause_tb = 0;
#1;


restart_tb = 0;
pause_tb = 1;
#1;

restart_tb = 0;
pause_tb = 0;
#1;
restart_tb = 0;
pause_tb = 1;
#1;
restart_tb = 0;
pause_tb = 0;
#1;

restart_tb = 0;
pause_tb = 0;
#1;

restart_tb = 0;
pause_tb = 1;
#1;



end





endmodule 