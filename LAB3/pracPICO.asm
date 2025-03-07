                    ; KCPSM3 Program - Practice Picoblaze on Spartan-3A Starter Kit.
                    ;
                    ;
                    ;
                    ;
                    ; The 8 LEDs provide a simple 'heart beat' counter driven by interrupts generated at
                    ; one second intervals.
                    ;
                    ;
                    ;**************************************************************************************
                    ; Port definitions
                    ;**************************************************************************************
                    ;
                    ;
                    ;
                    CONSTANT LED_port, 80               ;8 simple LEDs. Is an OUTPUT port.
			        CONSTANT DATA_IN_PORT, 00	        ;input data port. this is an INPUT port.

                 
                    ;
                    ;
                    ;
                    ; LCD interface ports
                    ;
                    ; The 8-bit communication interface can be used on the Spartan-3A Starter Kit
                    ; as all pins are connected and dedicated.
                    ;
                    CONSTANT LCD_output_port, 40        ;LCD character module output data
                    CONSTANT LCD_input_port, 01         ;LCD character module input data
                    CONSTANT LCD_DB0, 01                ;   8-bit          DB4 - bit0
                    CONSTANT LCD_DB1, 02                ;   interface      DB5 - bit1
                    CONSTANT LCD_DB2, 04                ;                  DB6 - bit2
                    CONSTANT LCD_DB3, 08                ;                  DB7 - bit3
                    CONSTANT LCD_DB4, 10                ;                  DB4 - bit4
                    CONSTANT LCD_DB5, 20                ;                  DB5 - bit5
                    CONSTANT LCD_DB6, 40                ;                  DB6 - bit6
                    CONSTANT LCD_DB7, 80                ;                  DB7 - bit7
                    ;
                    CONSTANT LCD_control_port, 20       ;LCD character module control signals
                    CONSTANT LCD_E, 01                  ;   active High Enable        E - bit0
                    CONSTANT LCD_RW, 02                 ;   Read=1 Write=0           RW - bit1
                    CONSTANT LCD_RS, 04                 ;   Instruction=0 Data=1     RS - bit2
                   
                    ;**************************************************************************************
                    ; Special Register usage
                    ;**************************************************************************************
                    ;
                    ; No registers are given special names in this program.
                    ;
                    ;**************************************************************************************
                    ; Scratch Pad Memory Locations
                    ;**************************************************************************************
                    ;
                    ;
                    CONSTANT ISR_preserve_s0, 00        ;Preserve s0 contents during ISR
                    CONSTANT ISR_preserve_s1, 01        ;Preserve s1 contents during ISR
                    CONSTANT ISR_preserve_s2, 02        ;Preserve s2 contents during ISR
                    CONSTANT ISR_preserve_s3, 03        ;Preserve s3 contents during ISR
                    ;
                    CONSTANT LED_pattern, 04            ;remember state of LEDs (8-bit counter in this case)
                   
                    ;
                    ;**************************************************************************************
                    ; Useful data constants
                    ;**************************************************************************************
                    ;
                    ;
                    ; Constant to define a software delay of 1us. This must be adjusted to reflect the
                    ; clock applied to KCPSM3. Every instruction executes in 2 clock cycles making the
                    ; calculation highly predictable. The '6' in the following equation even allows for
                    ; 'CALL delay_1us' instruction in the initiating code.
                    ;
                    ; delay_1us_constant =  (clock_rate - 6)/4       Where 'clock_rate' is in MHz
                    ;
                    ; Example: For a 50MHz clock the constant value is (10-6)/4 = 11  (0B Hex).
                    ; For clock rates below 10MHz the value of 1 must be used and the operation will
                    ; become lower than intended. Interrupts may effect the timing of software based
                    ; delays.
                    ;
                    CONSTANT delay_1us_constant, 05
                    ;
                    ;
     
                    ;
                    ;
                    ;
                    ;
                    ;
                    ;**************************************************************************************
                    ; Initialise the system

			
				main:	
				
					ENABLE INTERRUPT 	
					INPUT s0,DATA_IN_PORT
					;ADD s3, 01   ;read current counter value
					COMPARE s3, FF   ; 255 
					ADDCY s3, 01
					CALL Z, display_LEDs
					CALL delay_1s
					
					
					
					JUMP main
					
					
					
					display_LEDs:
					
					DISABLE INTERRUPT
					
					FETCH s2, ISR_preserve_s2
					OUTPUT s2, LED_port
					LOAD s2, 00
					STORE s2, ISR_preserve_s2
					
					ENABLE INTERRUPT
					
					RETURN
					
		;**************************************************************************************
                    ; Software delay routines
                    ;**************************************************************************************
                    ;
                    ; Delay of 1us.
                    ;
                    ; Constant value 'delay_1us_constant' reflects the clock applied to KCPSM3. Every
                    ; instruction executes in 2 clock cycles making the calculation highly predictable.
                    ; The '6' in the following equation allows for the 'CALL delay_1us' instruction used
                    ; in the initiating code. Interrupts may effect software derived delays.
                    ;
                    ; delay_1us_constant =  (clock_rate - 6)/4       Where 'clock_rate' is in MHz
                    ;
                    ; Registers used s0
                    ;
         delay_1us: LOAD s0, delay_1us_constant
          wait_1us: SUB s0, 01
                    JUMP NZ, wait_1us
                    RETURN
                    ;
                    ; Delay of 40us.
                    ;
                    ; Registers used s0, s1
                    ;
        delay_40us: LOAD s1, 28                         ;40 x 1us = 40us
         wait_40us: CALL delay_1us
                    SUB s1, 01
                    JUMP NZ, wait_40us
                    RETURN
                    ;
                    ;
                    ; Delay of 1ms.
                    ;
                    ; Registers used s0, s1, s2
                    ;
         delay_1ms: LOAD s2, 19                         ;25 x 40us = 1ms
          wait_1ms: CALL delay_40us
                    SUB s2, 01
                    JUMP NZ, wait_1ms
                    RETURN
                    ;
                    ; Delay of 20ms.
                    ;
                    ; Delay of 20ms used during initialisation.
                    ;
                    ; Registers used s0, s1, s2, s3
                    ;
        delay_20ms: LOAD s3, 14                         ;20 x 1ms = 20ms
         wait_20ms: CALL delay_1ms
                    SUB s3, 01
                    JUMP NZ, wait_20ms
                    RETURN
                    ;
                    ; Delay of approximately 1 second.
                    ;
                    ; Registers used s0, s1, s2, s3, s4
                    ;
          delay_1s: LOAD s4, 32                         ;50 x 20ms = 1000ms
           wait_1s: CALL delay_20ms
                    SUB s4, 01
                    JUMP NZ, wait_1s
                    RETURN
                    ;
									




				

				
				    ; discard 8 msb for division 
				
			    ISR:
		
		
					STORE S3, ISR_preserve_s3  ; COUNTER
					FETCH s2, ISR_preserve_s2
					
					ADD s1, s0                          ;increment counter
                    ADDCY s2, s1 
					
					STORE s2, ISR_preserve_s2
					FETCH s3, ISR_preserve_s3  ; msb



                    ;**************************************************************************************
                    ; Interrupt Vector
                    ;**************************************************************************************
                    
					RETURNI ENABLE
                    ADDRESS 3FF
                    JUMP ISR
		
						
