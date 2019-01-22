module led_tb();

wire [7:0] LEDStb; 
reg clktb, resettb ;

LED_CONT LED_CONT( .LEDS(LEDStb), .clk(clktb), .reset(resettb));

initial forever begin
clktb = 0;
#1;
clktb= 1;
#1;
end
initial begin
 resettb = 1;
 #2;
 resettb = 0;
 #2;
resettb = 1;
 #2;
end


endmodule