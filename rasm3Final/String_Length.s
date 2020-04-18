/**************************
  Name:		Isaac Estrada
  Program:	Lab 15
  Class:	CS 3B
  Date:		March 30, 2020
 **************************/
 
@ Subroutine String_Length accepts the address of a string and counts the characters in the string, excluding the NULL character and returns that value as an int (word) in the R0 register. will read a string of characters terminated by a null
@    R0: Points to first byte of string to count
@    LR: Contains the return address

@ Returned register contents:
@    R0: Number of characters in the string (does not include null).
@ All registers are preserved as per AAPCS

	.global String_Length		@ Subroutine entry point

String_Length:
			
		push {r4-r8,r10,r11}	@ Preserve working register contents.
		
		mov r1, #0				@ start r1 at 0
		
loop:
		
		ldrb r2, [r0], #1
		
		cmp r2, #0				@ check to see is r2 is null
		
		beq end					@ If r2 is null branch to end
		
		add r1, #1				@ If r2 is not null then add 1 to r1
		
		b loop					@ Loop back and get next char in string
		
end:

		pop {r4-r8,r10,r11}		@ Restore saved register contents
		
		mov r0, r1				@ move r3 into r0 and return r0
		
		bx lr					@ Return back to caller
	
		.end
