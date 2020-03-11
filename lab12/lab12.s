@ Name: Caroline Ta
@ Program: Lab 11
@ Date: 03-11-2020

@ This program does the following:
@ Declare/Initial an array to hold 10 integers. Initialize to 0.
@ Execute a for loop to get a 10 numbers from the user and store them into the array.
@ Execute another for loop (must be different loop than #2)  to sum the values of the array.
@ Execute another for loop to print the values to the terminal.
@ Display the sum to the terminal.

@ Input values: 27	7	36	79	21	89	14	23	18	3

.data
		@ VARIABLES
			intArray:	.word 0,0,0,0,0, 0,0,0,0,0
			iSum:		.word 0
		

		@ INPUTS AND OUTPUTS PROMPTS
	 		crCr:		.byte 	10
	 		szSpace:	.asciz	"  "
	 		szInput:	.asciz	"Enter number: "
	 		szArElem:	.asciz	"Elements of the array: "
	 		szSumOut:	.asciz	"The sum is: "
			
		@ INPUT STRINGS FOR NUMS	
			szNum1:		.skip	12
			szSum:		.skip	12
			
		@ ADDRESS STRINGS FOR NUMS	
			szAdr1:		.skip	12

		@ INTEGERS FOR NUMS
			iNum1:		.word	0

.text

			.global _start 				@ Provide program starting address to Linker
		
_start:

		/********************************
		 ** PROMPT USERS FOR INT INPUT **
		 ********************************/	  
		 
			mov 	r3, #0				@ Index for array for FLoop_input
			mov		r4, #1				@ Count for FLoop_input
			
			mov		r5, #0				@ Index for array for FLoop_sum
			mov		r6, #1				@ Count for FLoop_sum
			
			mov		r7, #0				@ Index for array for FLoop_print
			mov		r8,	#1				@ Count for FLoop_print
						
			mov		r9, #0				@ Temp for sum
		 
FLoop_input:	

			ldr		r0, =szInput		@ Load into r0 the address of szInput				
			bl		putstring			@ Call putch macro to output  szInput
			
			ldr 	r0, =szNum1			@ Load into r0 the address of szNum1			
			mov 	r1, #12				@ Dictates maximum bytes in buffer
			bl 		getstring			@ Call getstring macro to get string input for szNum1														
								
		/*****************************************
		 ** CONVERT STRING INPUTS INTO INTEGERS **
		 *****************************************/
			ldr 	r0, =szNum1			@ Load into r0 the address of szNum1
			bl		ascint32			@ Convert ascii into an integer		
			ldr		r1,	=iNum1			@ Load into r1 the address of iNum1
			str		r0, [r1]			@ Store the value in r0 to the memory address at [r1]
		
		/***************************************
		 ** RETRIEVE VALUE AND STORE IN ARRAY **
		 ***************************************/
			ldr 	r1, =iNum1			@ Load into r1 the address of num1
			ldr 	r1, [r1]			@ Load the value of num1
		 		
			ldr		r2, =intArray		@ Load into r2 the address of r2
			str		r1, [r2, r3]		@ Store the value in r1 to the memory address at intArray[r3]
			
			add		r3, r3, #4			@ Next index: r3 += 4
			
			cmp		r4, #10				@ Compare if r4 > 10
			bge		Prompt_array		@ If r4 >= 10, go to Prompt_array
			
			add		r4, r4, #1			@ Increment count: r4++
			blt		FLoop_input			@ If r4 < 10, go to FLoop_input again
			
Prompt_array:

			ldr		r0, =crCr			@ Load into r0 the address of crCr
			bl		putch				@ Call putch macro to output newline
			
			ldr		r0, =szArElem		@ Load into r0 the address of szNum1				
			bl		putstring			@ Call putch macro to output  szNum1			
						
FLoop_sum:		
			ldr		r1, [r2, r5]		@ Load into r1: intArray[r5]
			add		r9, r1				@ r9 += r1 // Sum += r1
			
			add 	r5, r5, #4			@ Next index: r5 += 4			
			
			cmp		r6, #10				@ Compare if count > 10
			bge		FLoop_print			@ If r6 >= 10, go to FLoop_print			
			
			add		r6, r6, #1			@ Increment count: r6++
			blt		FLoop_sum			@ If r6 < 10, go to FLoop_sum again	
			
			
FLoop_print:		
			
			ldr		r3, [r2, r7]		@ Load into r3: intArray[r7]
			
			mov		r0, r3				@ Load into r0 the address of iNum1
			ldr		r1, =szNum1			@ Load into r1 the address of szNum1			
			bl		intasc32			@ Convert integer into ascii
			
			ldr		r0, =szNum1			@ Load into r0 the address of szNum1				
			bl		putstring			@ Call putch macro to output  szNum1
			
			ldr		r0, =szSpace		@ Load into r0 the address of szSpace
			bl		putstring			@ Call putch macro to output szSpace
			
			add		r7, r7, #4			@ Next index: r7 += r7			
			
			cmp		r8, #10				@ Compare if count > 10
			bge		Prompt_sum			@ If r8 >= 10, go to Prompt_sum
			
			add		r8, r8, #1			@ Increment count: r8++
			blt		FLoop_print			@ If r8 < 10, go to FLoop_print again
			
Prompt_sum:

			ldr		r0, =crCr			@ Load into r0 the address of crCr
			bl		putch				@ Call putch macro to output newline

			ldr		r0, =crCr			@ Load into r0 the address of crCr
			bl		putch				@ Call putch macro to output newline
		 
			ldr		r0, =szSumOut		@ Load into r0 the address of szCalc
			bl		putstring			@ Call putch macro to output  szCalc
			
			ldr 	r10, =iSum			@ Load into r8 the address of iCalc
			str 	r9, [r10]			@ Store the value in r6 to the memory address at [r8] 
			
			mov		r0, r9				@ Load into r0 the address of iCalc
			ldr		r1, =szSum			@ Load into r1 the address of szCalc			
			bl		intasc32			@ Convert integer into ascii
			
			ldr		r0, =szSum			@ Load into r0 the address of szCalc
			bl		putstring			@ Call putch macro to output  szCalc	 
		 
			ldr		r0, =crCr			@ Load into r0 the address of crCr
			bl		putch				@ Call putch macro to output newline			
			
end:			
		/*****************
		 ** END PROGRAM **
		 *****************/			
		 
			mov 	r0, #0				@ Exit Status code set to 0 indicates "normal completion"
			mov 	r7, #1 				@ Service command code (1) will terminate this program
			svc 	0      				@ Issue Linux command to terminate program
		
			.end

