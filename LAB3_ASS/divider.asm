; Divide Routine (8-bit / 8-bit = 8-bit result, remainder)
; ==================================================
; Shift and subtract algorithm
;
div_8by8:
	NAMEREG s0, dividend ; preserved
	NAMEREG s1, divisor ; preserved
	NAMEREG s2, quotient ; preserved
	NAMEREG s3, remainder ; modified
	NAMEREG s4, bit_mask ; used to test bits in dividend,
	; one-hot encoded, modified
	;
	LOAD remainder, 00 ; clear remainder
	LOAD bit_mask, 80 ; start with most-significant bit (msb)
div_loop:
	TEST dividend, bit_mask ; test bit, set CARRY if bit is '1'
	SLA remainder ; shift CARRY into lsb of remainder
	SL0 quotient ; shift quotient left (multiply by 2)
	;
	COMPARE remainder, divisor ; is remainder > divisor?
	JUMP C, no_sub ; if divisor is greater, continue to next bit
	SUB remainder, divisor ; if remainder > divisor, then subtract
	ADD quotient, 01 ; add one to quotient
no_sub:
	SR0 bit_mask ; shift to examine next bit position
	JUMP NZ, div_loop ; if bit_mask=0, then all bits examined
	; otherwise, examine next bit
	RETURN