//`timescale 1ns / 1ps
module test_bench_lab_5();


reg clk_tb, rst_tb,CLOCK_50_tb;

wire  [4:0] lfsr_tb;
wire out_sync_tb;
wire [11:0] sino_tb, mod_sig_tb ;

wire [4:0] lf_out;
LFSR lfsr_tbr(
.clk(clk_tb),
.rst(rst_tb),
.lfsr_out(lfsr_tb)

);

///*
edge_detect detec_tb( .async_sig(lfsr_tb[0]), // slow clock
		.outclk(CLOCK_50_tb), //fast clock
		.out_sync_sig(out_sync_tb),
		.VCC(1),
		.GND(0));


 sig_mod_2 mood_tb(
//input clock,
//input reset,
//.sync_sig(out_sync),
.lfsr_0(out_sync_tb),
.org_wave(sino_tb),
.mod_sig(mod_sig_tb)

);
		
	
		
waveform_gen waves_tb(

 // -- system signals
  .clk(CLOCK_50_tb),       //  : in  std_logic;
  .reset(!rst_tb),     //  : in  std_logic;
  
 // -- clock-enable
 .en(1'b1),         // : in  std_logic;
  
  //-- NCO frequency control
 .phase_inc(258),   //inc = Fout⋅232/ Fs 0.5   //(3e-6(2^32))/50 + 0.5  = 258.19803776 =258   3hz
  
//  -- Output waveforms
  .sin_out(sino_tb),   // 
  .cos_out(),   //  
  .squ_out(),  //   
  .saw_out() );  //  	
		
//*/
initial forever begin
// slow clock
clk_tb = 1;
#5;
clk_tb = 0;
#5;

end 

initial forever begin
// fast clock
CLOCK_50_tb = 1;
#2;
CLOCK_50_tb = 0;
#2;
end

initial begin

rst_tb = 1;
#1;
rst_tb = 0;
#1;
rst_tb = 1;
#1;
rst_tb = 0;
#1;


end


endmodule