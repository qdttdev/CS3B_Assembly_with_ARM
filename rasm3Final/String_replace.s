/**************************
  Name:		Isaac Estrada
  Program:	Rasm 3
  Class:	CS 3B
  Date:		April 8, 2020
 **************************/
 
@ Subroutine String_replace accepts the address of a string, a char to
@ replace, and a char to find the program will find all chars and 
@ replace the with the give char
@
@    R0: Points to first byte of string to count
@	 R1: contains a char to find in the string
@    R2: contains a char to replace the found chars
@    LR: Contains the return address

@ Returned register contents:
@
@    R0: Address of a string with the replaced chars.
@ 	 All registers are preserved as per AAPCS

.data

		szDesStr:	.skip 512


.global String_replace			@ Subroutine entry point

String_replace:

		mov r4, #0				@ Initialize r4 to 0

		push {r4-r8, r10, r11}	@ Preserve working register contents.
		
		ldr r6, =szDesStr		@ set the address of szDesStr to r6
		
loop:

		ldrb	r5, [r0, r4] 	@ load the next char into r5 from the string
		cmp		r5, #0			@ check if r5 is 0
		beq		end				@ if r5 is 0 branch to end
		
		cmp		r5, r1			@ check if r5 is r1
		beq		replace			@ branch to replace if r5 = r1
		
		strb	r5, [r6, r4]	@ store r5 into the new string		
		add		r4, r4, #1		@ add 1 to r4
				
		b		loop			@ loop back to top
					
		
replace:

		strb r2, [r6, r4]		@ store r2 into the new string
		
		add		r4, r4, #1		@ add 1 to r4
			
		b loop					@ loop back to the top

end:
		mov		r5, #0			@ load r5 with 0
		strb	r5, [r6, r4]	@ store r5 into the new string

		ldr r0, = szDesStr		@ pass back the new string to r0

		pop {r4-r8, r10, r11}	@ Restore saved register contents
		
		bx lr					@ Return back to caller
		
		.end
