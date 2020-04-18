/**************************
  Name:		Isaac Estrada
  Program:	Rasm 3
  Class:	CS 3B
  Date:		April 8, 2020
 **************************/
 
@ Subroutine String_indexOf_3 accepts the address of a string, another 
@ string it will find the first index location of the the other string 
@ in the string.
@
@    R0: Points to the address of a string
@	 R1: Points to the address of another string
@    LR: Contains the return address

@ Returned register contents:
@
@    R0: index location of the other string in the string.
@ 	 All registers are preserved as per AAPCS

	.global String_indexOf_3	@ Subroutine entry point

String_indexOf_3:

		push {r4-r8, r10, r11}	@ Preserve working register contents.
		
		mov r2, #0				@ Initialize r2 to 0
		mov r3, #0				@ Initialize r3 to 0
		mov r4, #0				@ Initialize r4 to 0
		mov r5, #0				@ Initialize r5 to 0	

loop:

		add r3, r5, r3			@ add r5 to r3 to carry over the looped indexes
	
		ldrb r4, [r1]			@ load the first char into r4 from the other string
		ldrb r2, [r0], #1		@ load the next char into r2 from the string
		
		cmp r2, #0				@ check to see is r2 is null
		beq end1				@ If r2 is null branch to end
		
		cmp r2, r4				@ check to see if r2 is r4
	
		mov r5, #0				@ load 0 into r5
		mov r6, #1				@ load 1 into r6
		beq check				@ branch to check if the first letter matches
		
		add r3, r3, #1			@ add 1 to r3 the found index
		
		b loop					@ loop back to loop
		
check:
		
		mov r5, #1				@ load 1 into r5
		
checkLoop:
		
		ldrb r4, [r1, r6]		@ load the next char into r4 from the other string
		ldrb r2, [r0], #1		@ load the next char into r2 from the string
		
		cmp r4, #0				@ check to see is r4 is null
		beq end2				@ If r4 is null branch to end2
		
		add r5, r5, #1			@ add 1 to r5
		
		cmp r4, r2				@ check to see if r4 is r2
		
		bne loop				@ branch to loop if the first letters dont match
		
		add r6, r6, #1			@ add 1 to r6 index of other string
		
		beq checkLoop			@ loop back to checkLoop

end1:
		
		mvn r0, #0				@ set r0 to -1
		
		pop {r4-r8, r10, r11}	@ Restore saved register contents
		
		bx lr					@ Return back to caller
		
end2:
		
		mov r0, r3				@ move r3 into r0 and return r0
		
		pop {r4-r8, r10, r11}	@ Restore saved register contents
		
		bx lr					@ Return back to caller
		
		.end
