/**************************
  Name:		Isaac Estrada
  Program:	Rasm 3
  Class:	CS 3B
  Date:		April 8, 2020
 **************************/
 
@ Subroutine String_indexOf_2 accepts the address of a string, char and 
@ string index, it will find the first index location of that char in 
@ the string after starting at the given index.
@
@    R0: Points to the address of a string
@	 R1: Contain the char being searched for
@	 R2: Contain the starting index
@    LR: Contains the return address

@ Returned register contents:
@
@    R0: index location of the char in the string.
@ 	 All registers are preserved as per AAPCS

	.global String_indexOf_2		@ Subroutine entry point

String_indexOf_2:

		push {r4-r8, r10, r11}	@ Preserve working register contents.
		
		mov r4, #0				@ Initialize r4 to 0
		mov r3, #0				@ Initialize r3 to 0
		
		ldrb r3, [r0]			@ load the first char into r3 from the string
		cmp r3, #0				@ check to see is r3 is null
		beq end					@ If r3 is null branch to end
		
countLoop:

		cmp r2, #0				@ check to see is r2 is null
		ble loop				@ branch to loop if at start index
				
		ldrb r3, [r0], #1		@ load the next char into r3 from the string
		
		sub r2, #1				@ sub 1 from r2 (counter)
		add r4, r4, #1			@ add 1 to r4 the found index
		
		b countLoop				@ loop back to countLop
		
loop:

		ldrb r3, [r0], #1		@ load the next char into r3 from the string
		
		cmp r3, #0				@ check to see is r3 is null
		
		beq end1				@ If r3 is null branch to end1
		
		cmp r3, r1				@ check to see is r2 is r1
		
		beq end					@ If found branch to end
		
		add r4, r4, #1			@ add 1 to r4
		
		b loop					@ loop back up to loop

end:
		mov r0, r4				@ move r3 into r0 and return r0
		
		pop {r4-r8, r10, r11}	@ Restore saved register contents
		
		bx lr					@ Return back to caller
		
end1:
		mvn r0, #0				@ set r0 to -1
		
		pop {r4-r8, r10, r11}	@ Restore saved register contents
		
		bx lr					@ Return back to caller
		
		.end
