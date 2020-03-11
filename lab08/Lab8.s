/**  Lab8.s **/
/* 02-22-20  */

.data
			szPromptNum1: 	.asciz	"Enter x: "
			szPromptNum2:	.asciz	"Enter y: "
			crCr:			.byte 	10
			
			szNum1:			.skip	12
			szNum2:			.skip	12
			
			szOut1:			.asciz 	"&x = "
			szOut2:			.asciz	"&y = "
			szAdr1:			.skip	12
			szAdr2:			.skip	12

			num1:			.word	0
			num2:			.word	0

.text

			.global _start 				@ Provide program starting address to Linker
		
_start:
		/*************************************
		 ** PROMPT USERS FOR X AND Y INPUTS **
		 *************************************/		
			ldr 	r0, =szPromptNum1	@ Load into r0 the address of szPromptNum1
			bl 		putstring			@ Call putstring macro to output: "Enter x: "
			
			ldr 	r0, =szNum1			@ Load into r0 the address of szNum1			
			mov 	r1, #12				@ Dictates maximum bytes in buffer
			bl 		getstring			@ Call getstring macro to get string input for szNum1		
		
			ldr 	r0, =szPromptNum2	@ Load into r0 the address of szPromptNum2
			bl 		putstring			@ Call putstring macro to output: "Enter y: "
			
			ldr 	r0, =szNum2			@ Load into r0 the address of szNum2
			mov 	r1, #12				@ Dictates maximum bytes in buffer
			bl 		getstring			@ Call getstring macro to get string input for szNum2
			
			ldr		r0, =crCr			@ Load into r0 the address of crCr
			bl		putch				@ Call putch macro to output newline
		
		/*****************************************
		 ** STORING szX AS AN INTEGER INTO num1 **
		 *****************************************/
			ldr 	r0, =szNum1			@ Load into r0 the address of szNum1
			bl		ascint32			@ Convert ascii into an integer		
			ldr		r1,	=num1			@ Load into r1 the address of num1
			str		r0, [r1]			@ Store the value in r0 to the memory address at [r1]		
		
		/*****************************************
		 ** STORING szY AS AN INTEGER INTO num2 **
		 *****************************************/
			ldr 	r0, =szNum2			@ Load into r0 the address of szNum2
			bl		ascint32			@ Convert ascii into integer		
			ldr		r1,	=num2			@ Load into r1 the address of num2
			str		r0, [r1]			@ Store the value in r0 to the memory address at [r1]
		
		
		/********************************************************
		 ** COMPARE num1 & num2 THEN STORE LARGEST NUM INTO r0 **
		 ********************************************************/
			ldr 	r1, =num1			@ Load into r1 the address of num1
			ldr 	r1, [r1]			@ Load the value of num1
			
			ldr 	r2, =num2			@ Load into r2 the address of num2
			ldr 	r2, [r2]			@ Load the value of num2
		 		
			cmp		r1, r2				@ Compare if r1 > r2
			movgt	r0, r1				@ Then move r1 into r0
			movle	r0, r2				@ Else move r2 into r0				
		
		/**************************** 
		 ** OUTPUT X & Y ADDRESSES **
		 ****************************/
			ldr 	r8, =num1 			@ Load into r8 the address of iX
			ldr		r9, =num2			@ Load into r9 the address of iY
			
			mov		r0, r8				@ Copy contents of r8 into r0
			ldr		r1, =szAdr1			@ Load into r1 the address of szAdrX
			mov		r2, #8				@ Dictates number of nibbles
			bl		hexToChar			@ Convert from hex into characters
			
			mov		r0, r9				@ Copy contents of r9 into r0
			ldr		r1, =szAdr2			@ Load into r1 the address of szAdrY
			mov		r2, #8				@ Dictates number of nibbles
			bl		hexToChar			@ Convert from hex into characters	
			
			ldr 	r0, =szOut1			@ Load into r0 the address of szOutX
			bl 		putstring			@ Call putch macro to output szOutX
			
			ldr		r0, =szAdr1			@ Load into r0 the address of szAdrX
			bl		putstring			@ Call putch macro to output szAdrX
			
			ldr		r0, =crCr			@ Load into r0 the address of crCr
			bl		putch				@ Call putch macro to output newline
			
			ldr 	r0,=szOut2			@ Load into r0 the address of szOutY
			bl 		putstring			@ Call putch macro to output szOutY
			
			ldr		r0, =szAdr2			@ Load into r0 the address of szAdrY
			bl		putstring			@ Call putch macro to output szAdrY
			
			ldr		r0, =crCr			@ Load into r0 the address of crCr
			bl		putch				@ Call putch macro to output newline
		
		/*****************
		 ** END PROGRAM **
		 *****************/
			mov 	r0, #0				@ Exit Status code set to 0 indicates "normal completion"
			mov 	r7, #1 				@ Service command code (1) will terminate this program
			svc 	0      				@ Issue Linux command to terminate program
		
			.end

