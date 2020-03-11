/**  Lab7.s **/
/* 02-16-20  */

.data
		@ CLASS HEADER	
			szName:		.asciz	" Name: Caroline Ta"
			szClass:	.asciz	"Class: CS 3B"
			szLab:		.asciz	"  Lab: RASM1"
			szDate:		.asciz	" Date: 02-16-2020"

		@ INPUTS AND OUTPUTS PROMPTS
			szPrompt:	.asciz	"Enter a whole number: "
			szOut:		.asciz	"The addresses of the 4 ints: "
			szSpace:	.asciz	"  "
			szPlus:		.asciz	" + "
			szMinus:	.asciz	" - "
			szEqual:	.asciz	" = "
			szLeftP:	.asciz	"("
			szRightP:	.asciz	")"
			crCr:		.byte 	10
			
		@ INPUT STRINGS FOR NUMS	
			szNum1:		.skip	12
			szNum2:		.skip	12
			szNum3:		.skip	12
			szNum4:		.skip	12
			szCalc:		.skip 	12
			
		@ ADDRESS STRINGS FOR NUMS	
			szAdr1:		.skip	12
			szAdr2:		.skip	12
			szAdr3:		.skip	12
			szAdr4:		.skip	12

		@ INTEGERS FOR NUMS
			iNum1:		.word	0
			iNum2:		.word	0
			iNum3:		.word	0
			iNum4:		.word	0
			iCalc:		.word	0

.text

			.global _start 				@ Provide program starting address to Linker
		
_start:

		/************************
		 ** PRINT CLASS HEADER **
		 ************************/
			ldr 	r0, =szName			@ Load into r0 the address of szName
			bl 		putstring			@ Call putstring macro to output
			ldr		r0, =crCr			@ Load into r0 the address of crCr
			bl		putch				@ Call putch macro to output newline
			
			ldr 	r0, =szClass		@ Load into r0 the address of szClass
			bl 		putstring			@ Call putstring macro to output
			ldr		r0, =crCr			@ Load into r0 the address of crCr
			bl		putch				@ Call putch macro to output newline
			
			ldr 	r0, =szLab			@ Load into r0 the address of szLab
			bl 		putstring			@ Call putstring macro to output
			ldr		r0, =crCr			@ Load into r0 the address of crCr
			bl		putch				@ Call putch macro to output newline
			
			ldr 	r0, =szDate			@ Load into r0 the address of szDate
			bl 		putstring			@ Call putstring macro to output
			ldr		r0, =crCr			@ Load into r0 the address of crCr
			bl		putch				@ Call putch macro to output newline
			
			ldr		r0, =crCr			@ Load into r0 the address of crCr
			bl		putch				@ Call putch macro to output newline

		/************************************
		 ** PROMPT USERS FOR 4 INTS INPUTS **
		 ************************************/		
			ldr 	r0, =szPrompt		@ Load into r0 the address of szPromptX
			bl 		putstring			@ Call putstring macro to output: "Enter a whole number: "
			ldr 	r0, =szNum1			@ Load into r0 the address of szNum1			
			mov 	r1, #12				@ Dictates maximum bytes in buffer
			bl 		getstring			@ Call getstring macro to get string input for szNum1	
			
			ldr 	r0, =szPrompt		@ Load into r0 the address of szPromptX
			bl 		putstring			@ Call putstring macro to output: "Enter a whole number: "
			ldr 	r0, =szNum2			@ Load into r0 the address of szNum1			
			mov 	r1, #12				@ Dictates maximum bytes in buffer
			bl 		getstring			@ Call getstring macro to get string input for szNum2
			
			ldr 	r0, =szPrompt		@ Load into r0 the address of szPromptX
			bl 		putstring			@ Call putstring macro to output: "Enter a whole number: "
			ldr 	r0, =szNum3			@ Load into r0 the address of szNum1			
			mov 	r1, #12				@ Dictates maximum bytes in buffer
			bl 		getstring			@ Call getstring macro to get string input for szNum3
			
			ldr 	r0, =szPrompt		@ Load into r0 the address of szPromptX
			bl 		putstring			@ Call putstring macro to output: "Enter a whole number: "
			ldr 	r0, =szNum4			@ Load into r0 the address of szNum1			
			mov 	r1, #12				@ Dictates maximum bytes in buffer
			bl 		getstring			@ Call getstring macro to get string input for szNum4			
						
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
			
			ldr 	r0, =szNum3			@ Load into r0 the address of szNum3
			bl		ascint32			@ Convert ascii into an integer		
			ldr		r1,	=iNum3			@ Load into r1 the address of iNum3
			str		r0, [r1]			@ Store the value in r0 to the memory address at [r1]
			
			ldr 	r0, =szNum4			@ Load into r0 the address of szNum4
			bl		ascint32			@ Convert ascii into an integer		
			ldr		r1,	=iNum4			@ Load into r1 the address of iNum4
			str		r0, [r1]			@ Store the value in r0 to the memory address at [r1]
		
		
		/******************************************************************
		 ** RETRIEVING VALUES OF 4 INTS AND STORE CALCULATION INTO iCalc **
		 ******************************************************************/
			ldr 	r0, =iNum1			@ Load into r0 the address of iNum1
			ldr 	r0, [r0]			@ Load the value of iNum1			
			ldr 	r1, =iNum2			@ Load into r1 the address of iNum2
			ldr 	r1, [r1]			@ Load the value of iNum2			
			add 	r2, r0, r1			@ Add values of r0 and r1 and store into r2
			
			ldr 	r3, =iNum3			@ Load into r0 the address of iNum3
			ldr 	r3, [r3]			@ Load the value of iNum3			
			ldr 	r4, =iNum4			@ Load into r1 the address of iNum4
			ldr 	r4, [r4]			@ Load the value of iNum4			
			add 	r5, r3, r4			@ Add values of r3 and r4 and store into r5
			
			sub		r6, r2, r5			@ Sub values of r2-r5 and store into r6
			
			ldr 	r8, =iCalc			@ Load into r8 the address of iCalc
			str 	r6, [r8]			@ Store the value in r6 to the memory address at [r8] 
				
		/*******************************************
		 ** STORING iCalc AS A STRING INTO szCalc **
		 *******************************************/
			mov		r0, r6				@ Load into r0 the address of iCalc
			ldr		r1, =szCalc			@ Load into r1 the address of szCalc			
			bl		intasc32			@ Convert integer into ascii		
			
			
		/************************ 
		 ** OUTPUT CALCULATION **
		 ************************/	
			ldr		r0, =szLeftP		@ Load into r0 the address of szLeftP
			bl		putstring			@ Call putch macro to output  szLeftP			
			ldr		r0, =szNum1			@ Load into r0 the address of szNum1
			bl		putstring			@ Call putch macro to output  szNum1									
			ldr		r0, =szPlus			@ Load into r0 the address of szPlus
			bl		putstring			@ Call putch macro to output  szPlus			
			ldr		r0, =szNum2			@ Load into r0 the address of szNum2
			bl		putstring			@ Call putch macro to output  szNum2			
			ldr		r0, =szRightP		@ Load into r0 the address of szRightP
			bl		putstring			@ Call putch macro to output  szRightP
			
			
			ldr		r0, =szMinus		@ Load into r0 the address of szMinus
			bl		putstring			@ Call putch macro to output  szMinus
			
			
			ldr		r0, =szLeftP		@ Load into r0 the address of szLeftP
			bl		putstring			@ Call putch macro to output  szLeftP			
			ldr		r0, =szNum3			@ Load into r0 the address of szNum3
			bl		putstring			@ Call putch macro to output  szNum3			
			ldr		r0, =szPlus			@ Load into r0 the address of szPlus
			bl		putstring			@ Call putch macro to output  szPlus			
			ldr		r0, =szNum4			@ Load into r0 the address of szNum4
			bl		putstring			@ Call putch macro to output  szNum4			
			ldr		r0, =szRightP		@ Load into r0 the address of szRightP
			bl		putstring			@ Call putch macro to output  szRightP
			
									
			ldr		r0, =szEqual		@ Load into r0 the address of szEqual	
			bl		putstring			@ Call putch macro to output  szEqual
			
			
			ldr		r0, =szCalc			@ Load into r0 the address of szCalc
			bl		putstring			@ Call putch macro to output  szCalc
			
			ldr		r0, =crCr			@ Load into r0 the address of crCr
			bl		putch				@ Call putch macro to output  newline			
			ldr		r0, =crCr			@ Load into r0 the address of crCr
			bl		putch				@ Call putch macro to output  newline
			
			
		/******************************** 
		 ** OUTPUT ADDRESSES OF 4 INTS **
		 ********************************/
			ldr 	r0, =szOut			@ Load into r0 the address of szOut
			bl 		putstring			@ Call putstring macro to output
			ldr		r0, =crCr			@ Load into r0 the address of crCr
			bl		putch				@ Call putch macro to output newline
		 		
			ldr 	r9,  =iNum1			@ Load into r9  the address of iNum1
			ldr		r10, =iNum2			@ Load into r10 the address of iNum2
			ldr 	r11, =iNum3 		@ Load into r11 the address of iNum3
			ldr		r12, =iNum4			@ Load into r12 the address of iNum4
			
			mov		r0, r9				@ Copy contents of r9 into r0
			ldr		r1, =szAdr1			@ Load into r1 the address of szAdr1
			mov		r2, #8				@ Dictates number of nibbles
			bl		hexToChar			@ Convert from hex into characters
			
			mov		r0, r10				@ Copy contents of r10 into r0
			ldr		r1, =szAdr2			@ Load into r1 the address of szAdr2
			mov		r2, #8				@ Dictates number of nibbles
			bl		hexToChar			@ Convert from hex into characters
			
			mov		r0, r11				@ Copy contents of r11 into r0
			ldr		r1, =szAdr3			@ Load into r1 the address of szAdr3
			mov		r2, #8				@ Dictates number of nibbles
			bl		hexToChar			@ Convert from hex into characters
			
			mov		r0, r12				@ Copy contents of r12 into r0
			ldr		r1, =szAdr4			@ Load into r1 the address of szAdr4
			mov		r2, #8				@ Dictates number of nibbles
			bl		hexToChar			@ Convert from hex into characters
			
					
			ldr		r0, =szAdr1			@ Load into r0 the address of szAdr1
			bl		putstring			@ Call putch macro to output  szAdr1			
			ldr		r0, =szSpace		@ Load into r0 the address of szSpace
			bl		putstring			@ Call putch macro to output  szSpace
			
			ldr		r0, =szAdr2			@ Load into r0 the address of szAdr2
			bl		putstring			@ Call putch macro to output  szAdr2			
			ldr		r0, =szSpace		@ Load into r0 the address of szSpace
			bl		putstring			@ Call putch macro to output  szSpace
			
			ldr		r0, =szAdr3			@ Load into r0 the address of szAdr3
			bl		putstring			@ Call putch macro to output  szAdr3			
			ldr		r0, =szSpace		@ Load into r0 the address of szSpace
			bl		putstring			@ Call putch macro to output  szSpace
			
			ldr		r0, =szAdr4			@ Load into r0 the address of szAdr4
			bl		putstring			@ Call putch macro to output  szAdr4			
			ldr		r0, =crCr			@ Load into r0 the address of crCr
			bl		putch				@ Call putch macro to output  newline				
			
		
		/*****************
		 ** END PROGRAM **
		 *****************/
			mov 	r0, #0				@ Exit Status code set to 0 indicates "normal completion"
			mov 	r7, #1 				@ Service command code (1) will terminate this program
			svc 	0      				@ Issue Linux command to terminate program
		
			.end

