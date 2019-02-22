 
 CONSTANT LED_port, 80               ;8 simple LEDs. Is an OUTPUT port.
 CONSTANT DATA_IN_PORT, 00	        ;input data port. this is an INPUT port.
 
 
 
 
         cold_start: LOAD s0, 00 
					LOAD s1, 00;clear 1 second counter and clear LEDs
                    STORE s0, LED_pattern
                    OUTPUT s0, LED_port
                    ;
                    ENABLE INTERRUPT 
	


	



    check_data_in: INPUT s0,DATA_IN_PORT     		;get status of switches
			  COMPARE s4, 00    			;test to see if first num flag is zero
			  JUMP Z, save_first_num 	;if the flag is 0, then save first num
		      JUMP NZ, accum_num
     	;	  CALL delay_1s; ; one second delay 
			  JUMP check_data_in;
					
					
	
	save_first_num: LOAD s2, s0
					LOAD s0, DATA_IN_PORT  ; dividend
					LOAD s4, 01  ; set first num flag to one  ; flag
					LOAD s1, 01 ; first interrupt service  ; diviser
					JUMP accum_num
	

	accum_num:  ADD s2, s0   ; add the numbers together 
				ADD s1, 01   ; increment 256 counter 
				COMPARE s1, 100 ; compare if it is the 256th interrupt 
				JUMP Z divide_numn ; if tru zero flag is set to 1
				JUMP NZ check_data_in
				
				
	divide_numn:
				LOAD s0,s2  ; dividend 
				CALL div_8by8
				CALL check_bit
				JUMP check_data_in
				RETURN
		

	check_bit: 
		NAMEREG s4, bit_mask ; used to test bits in dividend,		
		NAMEREG s2, quotient ; preserved
		NAMEREG s0, bit_counter 
		LOAD bit_mask, 80; ; start with most-significant bit (msb)
		LOAD bit_counter, 0 
		
	bit_loop:
	
		TEST quotient, bit_mask  ; test bit, set CARRY if bit is '1'
		JUMP C found_bit 
		SR0 bit_mask ; shift to examine next bit position
		ADD bit_counter, 1
		JUMP bit_loop
	
	ISR: 
	
	STORE s0, ISR_preserve_s0
	FETCH s0, bit_counter
	OUTPUT s0, LED_PORT  ;display counter value on LEDs
	FETCH s0, ISR_preserve_s0           ;restore register
 
	RETURNI ENABLE
	
	ADDRESS 3FF
    JUMP ISR
			