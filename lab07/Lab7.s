/**  Lab7.s **/
/* 02-19-20  */

.data
			szPromptX: 	.asciz	"Enter x: "
			szPromptY:	.asciz	"Enter y: "
			szPlus:		.asciz	" + "
			szEqual:	.asciz	" = "
			crCr:		.byte 	10
			
			szX:		.skip	12
			szY:		.skip	12
			szSum:		.skip 	12
			
			szOutX:		.asciz 	"&x = "
			szOutY:		.asciz	"&y = "
			szAdrX:		.skip	12
			szAdrY:		.skip	12

			iX:			.word	0
			iY:			.word	0
			iSum:		.word	0

.text

			.global _start 				@ Provide program starting address to Linker
		
_start:
		/*************************************
		 ** PROMPT USERS FOR X AND Y INPUTS **
		 *************************************/		
			ldr 	r0, =szPromptX		@ Load into r0 the address of szPromptX
			bl 		putstring			@ Call putstring macro to output: "Enter x: "
			
			ldr 	r0, =szX			@ Load into r0 the address of szX			
			mov 	r1, #12				@ Dictates maximum bytes in buffer
			bl 		getstring			@ Call getstring macro to get string input for szX		
		
			ldr 	r0, =szPromptY		@ Load into r0 the address of szPromptY
			bl 		putstring			@ Call putstring macro to output: "Enter y: ";
			
			ldr 	r0, =szY			@ Load into r0 the address of szY
			mov 	r1, #12				@ Dictates maximum bytes in buffer
			bl 		getstring			@ Call getstring macro to get string input for szY
			
			ldr		r0, =crCr			@ Load into r0 the address of crCr
			bl		putch				@ Call putch macro to output newline
		
		/***************************************
		 ** STORING szX AS AN INTEGER INTO iX **
		 ***************************************/
			ldr 	r0, =szX			@ Load into r0 the address of szX
			mov		r4, r0				@ Copy contents of r0 into r4
			bl		ascint32			@ Convert ascii into an integer		
			ldr		r1,	=iX				@ Load into r1 the address of iX
			str		r0, [r1]			@ Store the value in r0 to the memory address at [r1]		
		
		/***************************************
		 ** STORING szY AS AN INTEGER INTO iY **
		 ***************************************/
			ldr 	r0, =szY			@ Load into r0 the address of szY
			mov		r5, r0				@ Copy contents of r0 into r5 
			bl		ascint32			@ Convert ascii into integer		
			ldr		r1,	=iY				@ Load into r1 the address of iX
			str		r0, [r1]			@ Store the value in r0 to the memory address at [r1]
		
		
		/****************************************************************
		 ** RETRIEVING VALUES OF iX AND iY AND STORE THE SUM INTO iSum **
		 ****************************************************************/
			ldr 	r0, =iX				@ Load into r0 the address of iX
			ldr 	r0, [r0]			@ Load the value of iX
			
			ldr 	r1, =iY				@ Load into r1 the address of iY
			ldr 	r1, [r1]			@ Load the value of iY
			
			add 	r2, r0, r1			@ Add values of r0 and r1 and store into r2
			
			ldr 	r3, =iSum			@ Load into r3 the address of iSum
			str 	r2, [r3]			@ Store the value in r2 to the memory address at [r3] 
				
		/*****************************************
		 ** STORING iSum AS A STRINT INTO szSum **
		 *****************************************/
			mov		r0, r2				@ Load into r0 the address of iSum
			ldr		r1, =szSum			@ Load into r1 the address of szSum			
			bl		intasc32			@ Convert integer into ascii		
			
			
		/************************ 
		 ** OUTPUT CALCULATION **
		 ************************/	
			
			ldr		r0, =szX			@ Load into r0 the address of szX
			bl 		putstring			@ Call putch macro to output szX
									
			ldr		r0, =szPlus			@ Load into r0 the address of szPlus
			bl		putstring			@ Call putch macro to output szPlus
			
			ldr		r0, =szY			@ Load into r0 the address of szY
			bl		putstring			@ Call putch macro to output szY
			
			ldr		r0, =szEqual		@ Load into r0 the address of szEqual	
			bl		putstring			@ Call putch macro to output szEqual
			
			ldr		r0, =szSum			@ Load into r0 the address of szSum
			bl		putstring			@ Call putch macro to output szSum
			
			ldr		r0, =crCr			@ Load into r0 the address of crCr
			bl		putch				@ Call putch macro to output newline
			
			ldr		r0, =crCr			@ Load into r0 the address of crCr
			bl		putch				@ Call putch macro to output newline
			
			
		/**************************** 
		 ** OUTPUT X & Y ADDRESSES **
		 ****************************/
			ldr 	r8, =iX 			@ Load into r8 the address of iX
			ldr		r9, =iY				@ Load into r9 the address of iY
			
			mov		r0, r8				@ Copy contents of r8 into r0
			ldr		r1, =szAdrX			@ Load into r1 the address of szAdrX
			mov		r2, #8				@ Dictates number of nibbles
			bl		hexToChar			@ Convert from hex into characters
			
			mov		r0, r9				@ Copy contents of r9 into r0
			ldr		r1, =szAdrY			@ Load into r1 the address of szAdrY
			mov		r2, #8				@ Dictates number of nibbles
			bl		hexToChar			@ Convert from hex into characters
			
			ldr 	r0, =szOutX			@ Load into r0 the address of szOutX
			bl 		putstring			@ Call putch macro to output szOutX
			
			ldr		r0, =szAdrX			@ Load into r0 the address of szAdrX
			bl		putstring			@ Call putch macro to output szAdrX
			
			ldr		r0, =crCr			@ Load into r0 the address of crCr
			bl		putch				@ Call putch macro to output newline
			
			ldr 	r0,=szOutY			@ Load into r0 the address of szOutY
			bl 		putstring			@ Call putch macro to output szOutY
			
			ldr		r0, =szAdrY			@ Load into r0 the address of szAdrY
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

