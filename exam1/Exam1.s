@ Name: Caroline Ta
@ Program: Exam1
@ Date: 03-02-2020
@ This pprogram calculates the following formula: 2(x+2y-z)

.data
		@ CLASS HEADER	
			szName:		.asciz	"Author: Caroline Ta"			
			szDate:		.asciz	"Date: 03/02/2020"
			szLab:		.asciz	"Program: Exam1"

		@ INPUTS AND OUTPUTS PROMPTS
			szPromptX:	.asciz	"Enter x: "
			szPromptY:	.asciz	"Enter y: "
			szPromptZ:	.asciz	"Enter z: "
			szOut:		.asciz	"The addresses of the 4 ints: "
			szSpace:	.asciz	"  "
			szPlus:		.asciz	" + "
			szMinus:	.asciz	" - "
			szEqual:	.asciz	" = "
			szMultiply:	.asciz	"*"
			szLeftP:	.asciz	"("
			szRightP:	.asciz	")"
			szMult:		.asciz  "2"
			crCr:		.byte 	10
			
		@ INPUT STRINGS FOR NUMS	
			szNum1:		.skip	12
			szNum2:		.skip	12
			szNum3:		.skip	12
			szCalc:		.skip 	12
			
		@ ADDRESS STRINGS FOR NUMS	
			szAdr1:		.skip	12
			szAdr2:		.skip	12
			szAdr3:		.skip	12

		@ INTEGERS FOR NUMS
			iNum1:		.word	0
			iNum2:		.word	0
			iNum3:		.word	0
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
			
			ldr 	r0, =szDate			@ Load into r0 the address of szDate
			bl 		putstring			@ Call putstring macro to output
			ldr		r0, =crCr			@ Load into r0 the address of crCr
			bl		putch				@ Call putch macro to output newlin
			
			ldr 	r0, =szLab			@ Load into r0 the address of szLab
			bl 		putstring			@ Call putstring macro to output
			ldr		r0, =crCr			@ Load into r0 the address of crCr
			bl		putch				@ Call putch macro to output newline
			
			ldr		r0, =crCr			@ Load into r0 the address of crCr
			bl		putch				@ Call putch macro to output newline

		/************************************
		 ** PROMPT USERS FOR 3 INTS INPUTS **
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
			
			ldr 	r0, =szPromptZ		@ Load into r0 the address of szPromptX
			bl 		putstring			@ Call putstring macro to output: "Enter z: "
			ldr 	r0, =szNum3			@ Load into r0 the address of szNum1			
			mov 	r1, #12				@ Dictates maximum bytes in buffer
			bl 		getstring			@ Call getstring macro to get string input for szNum3			
						
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
		
		
		/******************************************************************
		 ** RETRIEVING VALUES OF 3 INTS AND STORE CALCULATION INTO iCalc **
		 ******************************************************************/
			ldr 	r0, =iNum1			@ Load into r0 the address of iNum1
			ldr 	r0, [r0]			@ Load the value of iNum1						@r0 = x
			ldr 	r1, =iNum2			@ Load into r1 the address of iNum2
			ldr 	r1, [r1]			@ Load the value of iNum2
			add		r1, r1, r1			@ Add values of r1+r1 into r1 					@r1 = 2y			
			add 	r2, r0, r1			@ Add values of r0 and r1 and store into r2		@r2 = x+2y
			
			ldr 	r3, =iNum3			@ Load into r0 the address of iNum3
			ldr 	r3, [r3]			@ Load the value of iNum3						@r3 = y
			
			sub		r6, r2, r3			@ Sub values of r2-r3 and store into r6			@r6 = r2-r3 = x+2y-z
			
			add		r6, r6, r6			@ Add values of r6+r6 into r6					@r6 = 2(x+2y-z)
			
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
		 
			ldr		r0, =szMult			@ Load into r0 the address of szLeftP				@2
			bl		putstring			@ Call putch macro to output  szLeftP		 
			ldr		r0, =szLeftP		@ Load into r0 the address of szLeftP				@(
			bl		putstring			@ Call putch macro to output  szLeftP			
			ldr		r0, =szNum1			@ Load into r0 the address of szNum1				@x
			bl		putstring			@ Call putch macro to output  szNum1									
			ldr		r0, =szPlus			@ Load into r0 the address of szPlus				@+
			bl		putstring			@ Call putch macro to output  szPlus
			
			ldr		r0, =szMult			@ Load into r0 the address of szLeftP				@2
			bl		putstring			@ Call putch macro to output  szLeftP
			
			ldr		r0, =szMultiply		@ Load into r0 the address of szLeftP				@*
			bl		putstring			@ Call putch macro to output  szLeftP
						
			ldr		r0, =szNum2			@ Load into r0 the address of szNum2				@y			
			bl		putstring			@ Call putch macro to output  szNum2			
			
			ldr		r0, =szMinus		@ Load into r0 the address of szMinus				@-
			bl		putstring			@ Call putch macro to output  szMinus
			
			ldr		r0, =szNum3			@ Load into r0 the address of szNum3				@z
			bl		putstring			@ Call putch macro to output  szNum3
						
			ldr		r0, =szRightP		@ Load into r0 the address of szRightP				@)			
			bl		putstring			@ Call putch macro to output  szRightP			
									
			ldr		r0, =szEqual		@ Load into r0 the address of szEqual				@=
			bl		putstring			@ Call putch macro to output  szEqual			
			
			ldr		r0, =szCalc			@ Load into r0 the address of szCalc
			bl		putstring			@ Call putch macro to output  szCalc
			
			ldr		r0, =crCr			@ Load into r0 the address of crCr
			bl		putch				@ Call putch macro to output  newline			
			ldr		r0, =crCr			@ Load into r0 the address of crCr
			bl		putch				@ Call putch macro to output  newline			
			
		/*****************
		 ** END PROGRAM **
		 *****************/
			mov 	r0, #0				@ Exit Status code set to 0 indicates "normal completion"
			mov 	r7, #1 				@ Service command code (1) will terminate this program
			svc 	0      				@ Issue Linux command to terminate program
		
			.end

