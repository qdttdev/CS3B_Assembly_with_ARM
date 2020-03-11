@ Name: Caroline Ta
@ Program: Lab 10
@ Date: 03-04-2020
@ This program compares two numbers and outputs their comparisons

.data
		@ INPUTS AND OUTPUTS PROMPTS
			szPromptX:	.asciz	"Enter x: "
			szPromptY:	.asciz	"Enter y: "
			szLT:		.asciz	" < "
			szGT:		.asciz	" > "
			szEQ:		.asciz	" = "
	 		crCr:		.byte 	10
			
		@ INPUT STRINGS FOR NUMS	
			szNum1:		.skip	12
			szNum2:		.skip	12
			
		@ ADDRESS STRINGS FOR NUMS	
			szAdr1:		.skip	12
			szAdr2:		.skip	12

		@ INTEGERS FOR NUMS
			iNum1:		.word	0
			iNum2:		.word	0

.text

			.global _start 				@ Provide program starting address to Linker
		
_start:

		/************************************
		 ** PROMPT USERS FOR 2 INTS INPUTS **
		 ************************************/		
			ldr 	r0, =szPromptX		@ Load into r0 the address of szPromptX
			bl 		putstring			@ Call putstring macro to output: "Enter x: "
			ldr 	r0, =szNum1			@ Load into r0 the address of szNum1			
			mov 	r1, #12				@ Dictates maximum bytes in buffer
			bl 		getstring			@ Call getstring macro to get string input for szNum1	
			
			ldr 	r0, =szPromptY		@ Load into r0 the address of szPromptX
			bl 		putstring			@ Call putstring macro to output: "Enter y: "
			ldr 	r0, =szNum2			@ Load into r0 the address of szNum1			
			mov 	r1, #12				@ Dictates maximum bytes in buffer
			bl 		getstring			@ Call getstring macro to get string input for szNum2			
						
			ldr		r0, =crCr			@ Load into r0 the address of crCr
			bl		putch				@ Call putch macro to output newline
		
		/*****************************************
		 ** CONVERT STRING INPUTS INTO INTEGERS **
		 *****************************************/
			ldr 	r0, =szNum1			@ Load into r0 the address of szNum1
			bl		ascint32			@ Convert ascii into an integer		
			ldr		r1,	=iNum1			@ Load into r1 the address of iNum1
			str		r0, [r1]			@ Store the value in r0 to the memory address at [r1]
			
			ldr 	r0, =szNum2			@ Load into r0 the address of szNum2
			bl		ascint32			@ Convert ascii into an integer		
			ldr		r1,	=iNum2			@ Load into r1 the address of iNum2
			str		r0, [r1]			@ Store the value in r0 to the memory address at [r1]
		
		/**************************************************
		 ** RETRIEVING VALUES OF 2 INTS AND COMPARE THEM **
		 **************************************************/
			ldr 	r1, =iNum1			@ Load into r1 the address of num1
			ldr 	r1, [r1]			@ Load the value of num1
			
			ldr 	r2, =iNum2			@ Load into r2 the address of num2
			ldr 	r2, [r2]			@ Load the value of num2
		 		
			cmp		r1, r2				@ Compare if r1 > r2
			blt		r1_lower			@ If r1 < r2,  goes to r1_lower			
			bgt		r1_higher			@ If r1 > r2,  goes to r2_higher
			beq		r1_equal			@ If r1 == r2, goes to r1_equal
				
r1_lower:	/** OUTPUT: x < y **/

			ldr		r0, =szNum1			@ Load into r0 the address of szNum1				
			bl		putstring			@ Call putch macro to output  szNum1
			
			ldr		r0, =szLT			@ Load into r0 the address of szLT				
			bl		putstring			@ Call putch macro to output  szLT
			
			ldr		r0, =szNum2			@ Load into r0 the address of szNum2							
			bl		putstring			@ Call putch macro to output  szNum2
			
			ldr		r0, =crCr			@ Load into r0 the address of crCr
			bl		putch				@ Call putch macro to output newline
			
			b		end					@ Goes to end
		
r1_higher:	/** OUTPUT: x > y **/

			ldr		r0, =szNum1			@ Load into r0 the address of szNum1				
			bl		putstring			@ Call putch macro to output  szNum1
			
			ldr		r0, =szGT			@ Load into r0 the address of szGT				
			bl		putstring			@ Call putch macro to output  szGT
			
			ldr		r0, =szNum2			@ Load into r0 the address of szNum2							
			bl		putstring			@ Call putch macro to output  szNum2
			
			ldr		r0, =crCr			@ Load into r0 the address of crCr
			bl		putch				@ Call putch macro to output newline
			
			b		end					@ Goes to end
			
r1_equal:	/** OUTPUT: x = y **/

			ldr		r0, =szNum1			@ Load into r0 the address of szNum1				
			bl		putstring			@ Call putch macro to output  szNum1
			
			ldr		r0, =szEQ			@ Load into r0 the address of szEQ				
			bl		putstring			@ Call putch macro to output  szEQ
			
			ldr		r0, =szNum2			@ Load into r0 the address of szNum2							
			bl		putstring			@ Call putch macro to output  szNum2
			
			ldr		r0, =crCr			@ Load into r0 the address of crCr
			bl		putch				@ Call putch macro to output newline
			
			b		end					@ Goes to end
			
					
end:			
		/*****************
		 ** END PROGRAM **
		 *****************/
			mov 	r0, #0				@ Exit Status code set to 0 indicates "normal completion"
			mov 	r7, #1 				@ Service command code (1) will terminate this program
			svc 	0      				@ Issue Linux command to terminate program
		
			.end

