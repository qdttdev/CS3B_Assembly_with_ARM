/**************************
  Name:		Isaac Estrada
  Program:	Rasm 3
  Class:	CS 3B
  Date:		April 8, 2020
 **************************/
 
@ Subroutine String_toLowerCase accepts the address of a string and then
@ converts all of its chars to lower case.
@
@    R0: Points to first byte of string
@    LR: Contains the return address
@
@ Returned register contents:
@
@    R0: Address of a string with lower case chars.
@ 	 All registers are preserved as per AAPCS

.data

		szDesStr:	.skip 512

.global String_toLowerCase		@ Subroutine entry point

String_toLowerCase:
			
		mov r1, #0				@ Initialize r1 to 0
		mov r2, #0				@ Initialize r2 to 0
		mov r3, #0				@ Initialize r3 to 0
		mov r4, #0				@ Initialize r4 to 0
		mov r5, #0				@ Initialize r5 to 0
		mov r6, #0				@ Initialize r6 to 0
		mov r7, #0				@ Initialize r7 to 0

		push {r4-r8, r10, r11}	@ Preserve working register contents.
		
		ldr r6, =szDesStr		@ set the address of szDesStr to r6
		
loop:

		ldrb	r5, [r0, r4] 	@ load the next char into r4 from the string 
		cmp		r5, #0			@ Initialize r5 to 0
		beq		end				@ branch to end if r5 is 0
		
		cmp		r5, #0x41		@ check to see if r5 is greater then 0x41
		bge		replace			@ branch to replace if r5 is greater then 0x41
		
		strb	r5, [r6, r4]	@ store r5 into the new string		
		add		r4, r4, #1		@ add 1 to r4	
				
		b		loop			@ loop back to top	
					
		
replace:

		cmp		r5, #0x5A		@ check to see if r5 is greater then 0x5A
		bgt		dontDoAnything	@ branch to dontDoAnything if r5 is greater then 0x5A

		add r7, r5, #0x20		@ add 0x20 to get the lower case of the letter

		strb r7, [r6, r4]		@ store r7 into the new string
		
		add		r4, r4, #1		@ add 1 to r4
		
		b loop					@ loop back to the top
		
dontDoAnything:
		
		strb	r5, [r6, r4]	@ store r5 into the new string				
		add		r4, r4, #1		@ add 1 to r4	
				
		b		loop			@ branch back to the top loop

end:
		mov		r5, #0			@ load 0 into r5
		strb	r5, [r6, r4]	@ store r5 into the new string	

		ldr r0, = szDesStr		@ load the address of szDesStr into r0

		pop {r4-r8, r10, r11}	@ Restore saved register contents
		
		bx lr					@ Return back to caller
		
		.end
