/**************************
  Name:		Isaac Estrada
  Program:	Rasm 3
  Class:	CS 3B
  Date:		April 8, 2020
 **************************/
 
@ Subroutine String_indexOf_1 accepts the address of a string and char 
@ and find the first index location of that char in the string.
@
@    R0: Points to the address of a string
@	 R1: Contain the char being searched for
@    LR: Contains the return address

@ Returned register contents:
@
@    R0: index location of the char in the string.
@ 	 All registers are preserved as per AAPCS

	.global String_indexOf_1		@ Subroutine entry point

String_indexOf_1:

		push {r4-r8, r10, r11}	@ Preserve working register contents.
		
		mov r2, #0				@ Initialize r2 to 0
		mov r3, #0				@ Initialize r3 to 0
		
		ldrb r2, [r0]			@ load the first char into r2 from the string
		cmp r2, #0				@ check to see is r2 is null
		beq end					@ If r2 is null branch to end
		
loop:

		ldrb r2, [r0], #1		@ Grab the next char in the String
		
		cmp r2, #0				@ check to see is r2 is null
		
		beq end					@ If r2 is null branch to end
		
		cmp r2, r1				@ check to see is r2 is r1
		
		beq end1				@ if found branch to end1
		
		add r3, r3, #1			@ if not found add 1 to r3 (counter
		
		b loop					@ Loop back to the top

end:

		pop {r4-r8, r10, r11}	@ Restore saved register contents
		
		mvn r0, #0				@ set r0 to -1
		
		bx lr					@ Return back to caller
		
end1:

		pop {r4-r8, r10, r11}	@ Restore saved register contents
		
		mov r0, r3				@ move r3 into r0 and return r0
		
		bx lr					@ Return back to caller
		
		.end
