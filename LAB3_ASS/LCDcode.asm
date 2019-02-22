 ; LCD interface ports
                    ;
                    ; The 8-bit communication interface can be used on the Spartan-3A Starter Kit
                    ; as all pins are connected and dedicated.
                    ;/*
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
					
					
					 ; ASCII table
                    ;
                    CONSTANT character_a, 61
                    CONSTANT character_b, 62
                    CONSTANT character_c, 63
                    CONSTANT character_d, 64
                    CONSTANT character_e, 65
                    CONSTANT character_f, 66
                    CONSTANT character_g, 67
                    CONSTANT character_h, 68
                    CONSTANT character_i, 69
                    CONSTANT character_j, 6A
                    CONSTANT character_k, 6B
                    CONSTANT character_l, 6C
                    CONSTANT character_m, 6D
                    CONSTANT character_n, 6E
                    CONSTANT character_o, 6F
                    CONSTANT character_p, 70
                    CONSTANT character_q, 71
                    CONSTANT character_r, 72
                    CONSTANT character_s, 73
                    CONSTANT character_t, 74
                    CONSTANT character_u, 75
                    CONSTANT character_v, 76
                    CONSTANT character_w, 77
                    CONSTANT character_x, 78
                    CONSTANT character_y, 79
                    CONSTANT character_z, 7A
                    CONSTANT character_A, 41
                    CONSTANT character_B, 42
                    CONSTANT character_C, 43
                    CONSTANT character_D, 44
                    CONSTANT character_E, 45
                    CONSTANT character_F, 46
                    CONSTANT character_G, 47
                    CONSTANT character_H, 48
                    CONSTANT character_I, 49
                    CONSTANT character_J, 4A
                    CONSTANT character_K, 4B
                    CONSTANT character_L, 4C
                    CONSTANT character_M, 4D
                    CONSTANT character_N, 4E
                    CONSTANT character_O, 4F
                    CONSTANT character_P, 50
                    CONSTANT character_Q, 51
                    CONSTANT character_R, 52
                    CONSTANT character_S, 53
                    CONSTANT character_T, 54
                    CONSTANT character_U, 55
                    CONSTANT character_V, 56
                    CONSTANT character_W, 57
                    CONSTANT character_X, 58
                    CONSTANT character_Y, 59
                    CONSTANT character_Z, 5A
                    CONSTANT character_0, 30
                    CONSTANT character_1, 31
                    CONSTANT character_2, 32
                    CONSTANT character_3, 33
                    CONSTANT character_4, 34
                    CONSTANT character_5, 35
                    CONSTANT character_6, 36
                    CONSTANT character_7, 37
                    CONSTANT character_8, 38
                    CONSTANT character_9, 39
                    CONSTANT character_colon, 3A
                    CONSTANT character_stop, 2E
                    CONSTANT character_semi_colon, 3B
                    CONSTANT character_minus, 2D
                    CONSTANT character_divide, 2F       ;'/'
                    CONSTANT character_plus, 2B
                    CONSTANT character_comma, 2C
                    CONSTANT character_less_than, 3C
                    CONSTANT character_greater_than, 3E
                    CONSTANT character_equals, 3D
                    CONSTANT character_space, 20
                    CONSTANT character_CR, 0D           ;carriage return
                    CONSTANT character_question, 3F     ;'?'
                    CONSTANT character_dollar, 24
                    CONSTANT character_exclaim, 21      ;'!'
                    CONSTANT character_BS, 08           ;Back Space command character
                    ;
                    ;
                    ;
					
	just_clear_the_display:                               ;if the switches are 0, then just clear the display
			  CALL LCD_clear;
		        CALL delay_1s;
			  JUMP main_program;
	

 hex_byte_to_ASCII: LOAD s2, s0                         ;remember value supplied
                    SR0 s0                              ;isolate upper nibble
                    SR0 s0
                    SR0 s0
                    SR0 s0
                    CALL hex_to_ASCII                   ;convert
                    LOAD s3, s0                         ;upper nibble value in s3
                    LOAD s0, s2                         ;restore complete value
                    AND s0, 0F                          ;isolate lower nibble
                    CALL hex_to_ASCII                   ;convert
                    LOAD s2, s0                         ;lower nibble value in s2
                    RETURN
                    ;
                    ; Convert hexadecimal value provided in register s0 into ASCII character
                    ;
                    ;Register used s0
                    ;

			hex_to_ASCII: SUB s0, 0A                          ;test if value is in range 0 to 9
                    JUMP C, number_char
                    ADD s0, 07  

		   number_char: ADD s0, 3A                          ;ASCII char 0 to 9 in range 30 to 40
         		 RETURN	


 display_hex_byte: CALL hex_byte_to_ASCII
                    LOAD s5, s3
                    CALL LCD_write_data
                    LOAD s5, s2
                    CALL LCD_write_data
                    RETURN
                    ;				 
					
display_hex_32_bit: LOAD s6, 04                         ;4 bytes to display
       disp32_loop: FETCH s0, (s7)                      ;read byte
                    CALL display_hex_byte               ;display byte
                    SUB s7, 01                          ;decrement pointer
                    SUB s6, 01                          ;count bytes displayed
                    RETURN Z
                    JUMP disp32_loop
                    ;
                    ;
					
					
  ;**************************************************************************************
                    ; LCD text messages
                    ;**************************************************************************************
                    ;
                    ;			
                    ;
                    ; Display a space on LCD at current cursor position
                    ;
        disp_space: LOAD s5, character_space
                    CALL LCD_write_data
                    RETURN
                    ;
                    ; Display a message
                    ;
        disp_line1: LOAD s5, character_F
                    CALL LCD_write_data
                    LOAD s5, character_P
                    CALL LCD_write_data
                   
			        LOAD s5, character_G
                    CALL LCD_write_data
                    LOAD s5, character_A
                    CALL LCD_write_data
                    LOAD s5, character_s
                    CALL LCD_write_data
					CALL disp_space
			  
			        LOAD s5, character_a
                    CALL LCD_write_data
			        LOAD s5, character_r
                    CALL LCD_write_data
 			        LOAD s5, character_e
                    CALL LCD_write_data
                   
                    RETURN

disp_line2:         LOAD s5, character_t
                    CALL LCD_write_data
                    LOAD s5, character_h
                    CALL LCD_write_data
 			        LOAD s5, character_e
                    CALL LCD_write_data
                                     
  			  ;
                    CALL disp_space
			  ;
		
                    LOAD s5, character_B
                    CALL LCD_write_data
                    LOAD s5, character_E
                    CALL LCD_write_data
                    LOAD s5, character_S
                    CALL LCD_write_data
                    LOAD s5, character_T
                    CALL LCD_write_data
                    
					RETURN

	                    ;
                    ;**************************************************************************************
                    ; LCD Character Module Routines
                    ;**************************************************************************************
                    ;
                    ; LCD module is a 16 character by 2 line display but all displays are very similar
                    ; On the Spartan-3A Starter Kit the 8-wire data interface can be used.
                    ;
                    ; The LCD modules are relatively slow and software delay loops are used to slow down
                    ; KCPSM3 adequately for the LCD to communicate. The delay routines are provided in
                    ; a different section (see above in this case).
                    ;
                    ;
                    ;
                    ; Write 8-bit instruction to LCD display.
                    ;
                    ; The 8-bit instruction should be provided in register s5.
                    ; After writing there is a delay >40us to allow time for the LCD process the instruction.
                    ;
                    ; Registers used s0,s1,s4,s5
                    ;
    LCD_write_inst: OUTPUT s5, LCD_output_port          ;data output
                    LOAD s4, 00                         ;RS=0 Instruction, RW=0 Write, E=0
                    OUTPUT s4, LCD_control_port
                    CALL LCD_pulse_E
                    CALL delay_40us                     ;wait >40us
                    RETURN
                    ;
                    ;
                    ;
                    ;
                    ; Write 8-bit data to LCD display.
                    ;
                    ; The 8-bit data should be provided in register s5.
                    ; After writing there is a delay >40us to allow time for the LCD process the data.
                    ;
                    ; Registers used s0,s1,s4,s5
                    ;
    LCD_write_data: OUTPUT s5, LCD_output_port          ;data output
                    LOAD s4, 04                         ;RS=1 Data, RW=0 Write, E=0
                    OUTPUT s4, LCD_control_port
                    CALL LCD_pulse_E
                    CALL delay_40us                     ;wait >40us
                    RETURN
                    ;
                    ;
                    ;
                    ;
                    ; Read 8-bit data from LCD display.
                    ;
                    ; The 8-bit data will be read from the current LCD memory address
                    ; and will be returned in register s5.
                    ; It is advisable to set the LCD address (cursor position) before
                    ; using the data read for the first time otherwise the display may
                    ; generate invalid data on the first read.
                    ;
                    ; A delay of >40us is required after each read
                    ;
                    ; Registers used s0,s1,s4,s5
                    ;
     LCD_read_data: LOAD s4, 06                         ;RS=1 Data, RW=1 Read, E=0
                    OUTPUT s4, LCD_control_port         ;set up RS and RW >40ns before enable pulse
                    XOR s4, LCD_E                       ;E=1
                    OUTPUT s4, LCD_control_port
                    CALL delay_1us                      ;wait >260ns to access data
                    INPUT s5, LCD_input_port            ;read data
                    XOR s4, LCD_E                       ;E=0
                    OUTPUT s4, LCD_control_port
                    LOAD s4, 04                         ;RS=1 Data, RW=0 Write, E=0
                    OUTPUT s4, LCD_control_port         ;Stop reading 5V device
                    CALL delay_40us                     ;wait >40us
                    RETURN
                    ;
                    ;
                    ; Pulse LCD enable signal 'E' high for greater than 230ns (1us is used).
                    ;
                    ; Register s4 should define the current state of the LCD control port.
                    ;
                    ; Registers used s0, s4
                    ;
       LCD_pulse_E: XOR s4, LCD_E                       ;E=1
                    OUTPUT s4, LCD_control_port
                    CALL delay_1us
                    XOR s4, LCD_E                       ;E=0
                    OUTPUT s4, LCD_control_port
                    RETURN
                    ;
                    ;
                    ;
                    ; Reset and initialise display to communicate using 8-bit data mode
                    ; Includes routine to clear the display.
                    ;
                    ; Requires the 8-bit instructions 38,38,38,28 to be sent with suitable delays
                    ; following by the 8-bit instructions to set up the display.
                    ;
                    ;  38 = '001' Function set, '1' 4-bit mode, '1' 2-line, '0' 5x7 dot matrix, 'xx'
                    ;  06 = '000001' Entry mode, '1' increment, '0' no display shift
                    ;  0C = '00001' Display control, '1' display on, '0' cursor off, '0' cursor blink off
                    ;  01 = '00000001' Display clear
                    ;
                    ; Registers used s0, s1, s2, s3, s4
                    ;
         LCD_reset: CALL delay_20ms                     ;wait more that 15ms for display to be ready
                    LOAD s5, 38                         ;Function set
                    CALL LCD_write_inst                 ;write '38'
                    CALL delay_20ms                     ;wait >4.1ms
                    CALL LCD_write_inst                 ;write '38'
                    CALL delay_1ms                      ;wait >100us
                    CALL LCD_write_inst                 ;write '38' and wait >40us
                    CALL LCD_write_inst                 ;write 'Function Set' and wait >40us
                    LOAD s5, 06                         ;Entry mode
                    CALL LCD_write_inst                 ;write 'Entry mode' and wait >40us
                    LOAD s5, 0C                         ;Display control
                    CALL LCD_write_inst                 ;write 'Display control' and wait >40us
         LCD_clear: LOAD s5, 01                         ;Display clear
                    CALL LCD_write_inst
                    CALL delay_1ms                      ;wait >1.64ms for display to clear
                    CALL delay_1ms
                    RETURN
                    ;
                    ;
                    ;
                    ;
                    ; Position the cursor ready for characters to be written.
                    ; The display is formed of 2 lines of 16 characters and each
                    ; position has a corresponding address as indicated below.
                    ;
                    ;                   Character position
                    ;           0  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15
                    ;
                    ; Line 1 - 80 81 82 83 84 85 86 87 88 89 8A 8B 8C 8D 8E 8F
                    ; Line 2 - C0 C1 C2 C3 C4 C5 C6 C7 C8 C9 CA CB CC CD CE CF
                    ;
                    ; This routine will set the cursor position using the value provided
                    ; in register s5. The upper nibble will define the line and the lower
                    ; nibble the character position on the line.
                    ; Example s5 = 2B will position the cursor on line 2 position 11
                    ;
                    ; Registers used s0, s1, s2, s3, s4
                    ;
        LCD_cursor: TEST s5, 10                         ;test for line 1
                    JUMP Z, set_line2
                    AND s5, 0F                          ;make address in range 80 to 8F for line 1
                    OR s5, 80
                    CALL LCD_write_inst                 ;instruction write to set cursor
                    RETURN
         set_line2: AND s5, 0F                          ;make address in range C0 to CF for line 2
                    OR s5, C0
                    CALL LCD_write_inst                 ;instruction write to set cursor
                    RETURN
                    ;
                    ;
                    ;
                    ;
                    ; This routine will shift the complete display one position to the left.
                    ; The cursor position and LCD memory contents will not change.
                    ;
                    ;
                    ; Registers used s0, s1, s2, s3, s4, s5
                    ;
    LCD_shift_left: LOAD s5, 18                         ;shift display left
                    CALL LCD_write_inst
                    RETURN
                    ;
                    ;
                    ;				
					

