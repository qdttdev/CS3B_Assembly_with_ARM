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

	.global Factorial		@ Subroutine entry point

Factorial:
			
		push {r4-r8, r10, r11, r14}	@ Preserve working register contents.
		
		cmp r0, #1		@ Compare r0 to 1
		
		beq end			@ if r0 is 1 then branch to end
		
		mov r4, r0		@ move the value of r0 into r4
		
		sub r0, #1		@ subtract 1 from r0
		
		bl Factorial	@ branch to factorial 
		
		mul r0, r4, r0	@ Mulitply the values after returning from factorial
		
end:

		pop {r4-r8, r10, r11, r14}		@ Restore saved register contents
		
		bx lr								@ Return back to caller
	
		.end
		
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


@ Subroutine String_indexOf_1 accepts the address of a string and counts the characters in the string, excluding the NULL character and returns that value as an int (word) in the R0 register. will read a string of characters terminated by a null
@    R0: Points to first byte of string to count
@    LR: Contains the return address

@ Returned register contents:
@    R0: Number of characters in the string (does not include null).
@ All registers are preserved as per AAPCS

	.global String_indexOf_1		@ Subroutine entry point

String_indexOf_1:

		push {r4-r8, r10, r11}	@ Preserve working register contents.
		
loop:

		ldrb r2, [r0], #1
		
		cmp r2, #0				@ check to see is r2 is null
		
		beq end					@ If r2 is null branch to end
		
		cmp r2, r1				@ check to see is r2 is r1
		
		beq end					@ 
		
		add r3, r3, #1	
		
		b loop	

end:

		pop {r4-r8, r10, r1}		@ Restore saved register contents
		
		mov r0, r3				@ move r3 into r0 and return r0
		
		bx lr					@ Return back to caller
		
		.end
		

@ Subroutine String_indexOf_2 accepts the address of a string and counts the characters in the string, excluding the NULL character and returns that value as an int (word) in the R0 register. will read a string of characters terminated by a null
@    R0: Points to first byte of string to count
@    LR: Contains the return address

@ Returned register contents:
@    R0: Number of characters in the string (does not include null).
@ All registers are preserved as per AAPCS

	.global String_indexOf_2		@ Subroutine entry point

String_indexOf_2:

		push {r4-r8,r10,r11}	@ Preserve working register contents.

end:

		pop {r4-r8,r10,r11}		@ Restore saved register contents
		
		mov r0, r1				@ move r3 into r0 and return r0
		
		bx lr					@ Return back to caller
		
		.end
		
	
@ Subroutine String_indexOf_3 accepts the address of a string and counts the characters in the string, excluding the NULL character and returns that value as an int (word) in the R0 register. will read a string of characters terminated by a null
@    R0: Points to first byte of string to count
@    LR: Contains the return address

@ Returned register contents:
@    R0: Number of characters in the string (does not include null).
@ All registers are preserved as per AAPCS

	.global String_indexOf_3		@ Subroutine entry point

String_indexOf_3:

		push {r4-r8,r10,r11}	@ Preserve working register contents.

end:

		pop {r4-r8,r10,r11}		@ Restore saved register contents
		
		mov r0, r1				@ move r3 into r0 and return r0
		
		bx lr					@ Return back to caller
		
		.end
		
		
@ Subroutine String_lastIndexOf_1 accepts the address of a string and counts the characters in the string, excluding the NULL character and returns that value as an int (word) in the R0 register. will read a string of characters terminated by a null
@    R0: Points to first byte of string to count
@    LR: Contains the return address

@ Returned register contents:
@    R0: Number of characters in the string (does not include null).
@ All registers are preserved as per AAPCS

	.global String_lastIndexOf_1		@ Subroutine entry point

String_lastIndexOf_1:

		push {r4-r8,r10,r11}	@ Preserve working register contents.

end:

		pop {r4-r8,r10,r11}		@ Restore saved register contents
		
		mov r0, r1				@ move r3 into r0 and return r0
		
		bx lr					@ Return back to caller
		
		.end
		
		
@ Subroutine String_lastIndexOf_2 accepts the address of a string and counts the characters in the string, excluding the NULL character and returns that value as an int (word) in the R0 register. will read a string of characters terminated by a null
@    R0: Points to first byte of string to count
@    LR: Contains the return address

@ Returned register contents:
@    R0: Number of characters in the string (does not include null).
@ All registers are preserved as per AAPCS

	.global String_lastIndexOf_2		@ Subroutine entry point

String_lastIndexOf_2:

		push {r4-r8,r10,r11}	@ Preserve working register contents.

end:

		pop {r4-r8,r10,r11}		@ Restore saved register contents
		
		mov r0, r1				@ move r3 into r0 and return r0
		
		bx lr					@ Return back to caller
		
		.end
		
		
@ Subroutine String_lastIndexOf_3 accepts the address of a string and counts the characters in the string, excluding the NULL character and returns that value as an int (word) in the R0 register. will read a string of characters terminated by a null
@    R0: Points to first byte of string to count
@    LR: Contains the return address

@ Returned register contents:
@    R0: Number of characters in the string (does not include null).
@ All registers are preserved as per AAPCS

	.global String_lastIndexOf_3		@ Subroutine entry point

String_lastIndexOf_3:

		push {r4-r8,r10,r11}	@ Preserve working register contents.

end:

		pop {r4-r8,r10,r11}		@ Restore saved register contents
		
		mov r0, r1				@ move r3 into r0 and return r0
		
		bx lr					@ Return back to caller
		
		.end
		
		
@ Subroutine String_replace accepts the address of a string and counts the characters in the string, excluding the NULL character and returns that value as an int (word) in the R0 register. will read a string of characters terminated by a null
@    R0: Points to first byte of string to count
@    LR: Contains the return address

@ Returned register contents:
@    R0: Number of characters in the string (does not include null).
@ All registers are preserved as per AAPCS

	.global String_replace		@ Subroutine entry point

String_replace:

		push {r4-r8,r10,r11}	@ Preserve working register contents.

end:

		pop {r4-r8,r10,r11}		@ Restore saved register contents
		
		mov r0, r1				@ move r3 into r0 and return r0
		
		bx lr					@ Return back to caller
		
		.end
		
		
@ Subroutine String_toLowerCase accepts the address of a string and counts the characters in the string, excluding the NULL character and returns that value as an int (word) in the R0 register. will read a string of characters terminated by a null
@    R0: Points to first byte of string to count
@    LR: Contains the return address

@ Returned register contents:
@    R0: Number of characters in the string (does not include null).
@ All registers are preserved as per AAPCS

	.global String_toLowerCase		@ Subroutine entry point

String_toLowerCase:

		push {r4-r8,r10,r11}	@ Preserve working register contents.

end:

		pop {r4-r8,r10,r11}		@ Restore saved register contents
		
		mov r0, r1				@ move r3 into r0 and return r0
		
		bx lr					@ Return back to caller
		
		.end
		
		
@ Subroutine String_toUpperCase accepts the address of a string and counts the characters in the string, excluding the NULL character and returns that value as an int (word) in the R0 register. will read a string of characters terminated by a null
@    R0: Points to first byte of string to count
@    LR: Contains the return address

@ Returned register contents:
@    R0: Number of characters in the string (does not include null).
@ All registers are preserved as per AAPCS

	.global String_toUpperCase		@ Subroutine entry point

String_toUpperCase:

		push {r4-r8,r10,r11}	@ Preserve working register contents.

end:

		pop {r4-r8,r10,r11}		@ Restore saved register contents
		
		mov r0, r1				@ move r3 into r0 and return r0
		
		bx lr					@ Return back to caller
		
		.end
		
		
@ Subroutine String_concat accepts the address of a string and counts the characters in the string, excluding the NULL character and returns that value as an int (word) in the R0 register. will read a string of characters terminated by a null
@    R0: Points to first byte of string to count
@    LR: Contains the return address

@ Returned register contents:
@    R0: Number of characters in the string (does not include null).
@ All registers are preserved as per AAPCS

	.global String_concat		@ Subroutine entry point

String_concat:

		push {r4-r8,r10,r11}	@ Preserve working register contents.

end:

		pop {r4-r8,r10,r11}		@ Restore saved register contents
		
		mov r0, r1				@ move r3 into r0 and return r0
		
		bx lr					@ Return back to caller
		
		.end
