/**************************
  Name:		Isaac Estrada
  Program:	Rasm 3
  Class:	CS 3B
  Date:		April 8, 2020
 **************************/
 
@ Subroutine String_concat accepts the address of a string1 and an 
@ address of string2 and comibins string2 to the end of string1
@
@    R0: Points to first byte of string1
@	 R1: points to first byte of String2
@    LR: Contains the return address
@
@ Returned register contents:
@
@    R0: Address of a string with the concat strings
@ 	 All registers are preserved as per AAPCS

.data

		szDesStr:	.skip 512
	
.global String_concat			@ Subroutine entry point

String_concat:

		mov r4, #0				@ Initialize r4 to 0

		push {r4-r8, r10, r11}	@ Preserve working register contents.
		
		
		ldr 	r2, =szDesStr	@ set the address of szDesStr to r2
		mov 	r3, #0			@ Initialize r3 to 0
		mov     r5, #0			@ Initialize r5 to 0
		
loop1:	
	
		ldrb	r4, [r0, r3]	@ load the next char into r4 from the string
		
		cmp		r4, #0	  		@ check if r4 is 0
		beq		loop2			@ if r5 is 0 branch to loop2
		
		strb	r4, [r2, r3]	@ store r4 into the new string
		add		r3, r3, #1		@ add 1 to r3
			
		bne		loop1      		@ loop back to top
		
loop2:

		ldrb	r4, [r1, r5]	@ load the next char into r4 from the string
		
		cmp		r4, #0			@ check if r4 is 0
		beq		end				@ if r5 is 0 branch to end
		
		strb	r4, [r2, r3]	@ store r4 into the new string
		add		r3, r3, #1		@ add 1 to r3
		add		r5, r5, #1		@ add 1 to r5
		
		bne		loop2			@ loop back to loop2

end:
		mov		r5, #0			@ load r5 with 0
		strb	r5, [r2, r3]	@ store r5 into the new string

		ldr r0, = szDesStr		@ pass back the new string to r0

		pop {r4-r8, r10, r11}	@ Restore saved register contents
		
		bx lr					@ Return back to caller
		
		.end
