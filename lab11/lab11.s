@ Name: Caroline Ta
@ Program: Lab 11
@ Date: 03-09-2020
@ This program error checks numbers in range (0, 100) and ends when not in range.

.data
		@ INPUTS AND OUTPUTS PROMPTS
	 		crCr:		.byte 	10
			
		@ INPUT STRINGS FOR NUMS	
			szNum1:		.skip	12
			
		@ ADDRESS STRINGS FOR NUMS	
			szAdr1:		.skip	12

		@ INTEGERS FOR NUMS
			iNum1:		.word	0

.text

			.global _start 				@ Provide program starting address to Linker
		
_start:

		/************************************
		 ** PROMPT USERS FOR 2 INTS INPUTS **
		 ************************************/
			ldr 	r0, =szNum1			@ Load into r0 the address of szNum1			
			mov 	r1, #12				@ Dictates maximum bytes in buffer
			bl 		getstring			@ Call getstring macro to get string input for szNum1					
						
			ldr		r0, =crCr			@ Load into r0 the address of crCr
			bl		putch				@ Call putch macro to output newline
		
		/*****************************************
		 ** CONVERT STRING INPUTS INTO INTEGERS **
		 *****************************************/
			ldr 	r0, =szNum1			@ Load into r0 the address of szNum1
			bl		ascint32			@ Convert ascii into an integer		
			ldr		r1,	=iNum1			@ Load into r1 the address of iNum1
			str		r0, [r1]			@ Store the value in r0 to the memory address at [r1]
		
		/**************************************************
		 ** RETRIEVING VALUE AND CHECK IN RANGE (0, 100) **
		 **************************************************/
			ldr 	r1, =iNum1			@ Load into r1 the address of num1
			ldr 	r1, [r1]			@ Load the value of num1
		 		
			cmp		r1, #100			@ If r1 >  100						
			bgt		end					@ If r1 >  100, goes to end
			
			cmp		r1, #1				@ If r1 >  1
			bge		_start				@ If r1 >= 1, loops start
			blt		end					@ If r1 <  1, goes to end			
					
end:			
		/*****************
		 ** END PROGRAM **
		 *****************/
			mov 	r0, #0				@ Exit Status code set to 0 indicates "normal completion"
			mov 	r7, #1 				@ Service command code (1) will terminate this program
			svc 	0      				@ Issue Linux command to terminate program
		
			.end

