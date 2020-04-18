/**************************
  Name:		Isaac Estrada
  Program:	Rasm 3
  Class:	CS 3B
  Date:		April 8, 2020
 **************************/
 
@ Subroutine String_lastIndexOf_2 accepts the address of a string, char 
@ and starting index,  It returns the last occurrence of char, it starts 
@ looking backwards from the specified index.
@
@    R0: Points to the address of a string
@	 R1: Contain the char being searched for
@	 R2: Contain the starting index
@    LR: Contains the return address

@ Returned register contents:
@
@    R0: index location of the char in the string.
@ 	 All registers are preserved as per AAPCS

	.global String_lastIndexOf_2		@ Subroutine entry point

String_lastIndexOf_2:

		push {r4-r8, r10, r11}	@ Preserve working register contents.
		
		mov r5, #0				@ Initialize r5 to 0
		mov r4, #0				@ Initialize r4 to 0
		mov r3, #0				@ Initialize r3 to 0
		
		ldrb r3, [r0]			
		cmp r3, #0				@ check to see is r2 is null
		beq end					@ If r2 is null branch to end
		
		ldrb r3, [r0, r2]		@ load the first char into r3 from the string
		cmp r3, #0				@ check to see is r3 is null
		beq end					@ If r3 is null branch to end
		
		
loop:
		cmp r2, #0				@ check to see is r2 is null
		blt end1				@ If r2 is null branch to end
		
		ldrb r3, [r0, r2]		@ load the next char into r3 from the string
		
		cmp r3, r1				@ check to see is r2 is r1
		beq save				@ branch to save if the char match
		
		sub r2, r2, #1			@ sub 1 from r2 (counter)
		
		b loop					@ loop back up to loop
		

save:

		mov r5, r4				@ load value of r4 into r5
	
		sub r2, r2, #1			@ sub 1 from r2
	
		b loop					@ loop back to top
		
end1:

		cmp r5, #0				@ check if r5 is 0
		beq end2				@ if it is zero branch to end2
		
		mov r0, r5				@ move r3 into r0 and return r0
		
		pop {r4-r8, r10, r11}	@ Restore saved register contents
		
		bx lr					@ Return back to caller
		
end2:
		
		mvn r0, #0				@ set r0 to -1
		
		pop {r4-r8, r10, r11}	@ Restore saved register contents
		
		bx lr					@ Return back to caller
		
		.end
