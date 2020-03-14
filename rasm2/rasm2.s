/************************************************************************
 * Name:	Caroline Ta
 * Program:	rasm2.s
 * Class:	CS3B
 * Lab:		RASM 2
 * Date:	03-23-2020
 * Purpose:	Input numeric information from the keyboard, perform addition, 
 *			subtraction, multiplication, and division. Check for overflow 
 *			upon all operations. 
 ***********************************************************************/

.data
		@ CLASS HEADER	
			szName:		.asciz	"     Name:       Caroline Ta"
			szProg:		.asciz	"     Program:    rasm2.s"
			szClass:	.asciz	"     Class:      CS3B"
			szDate:		.asciz	"     Date:       03-23-2020"

		@ INPUTS AND OUTPUTS PROMPTS
			szNum1Pr:	.asciz	"Enter your first  number: "
			szNum2Pr:	.asciz	"Enter your second number: "
			szSumPr:	.asciz	"The sum is        : "
			szDifPr:	.asciz	"The difference is : "
			szProPr:	.asciz	"The product is    : "
			szQuoPr:	.asciz	"The quotient is   : "
			szRemPr:	.asciz	"The remainder is  : "
			szEnd:		.asciz	"Thanks for using my program!! Good Day!"
			szBorder:	.asciz	"---------------------------------------------------------------------"	
			szNull:		.asciz	""
			crCr:		.byte 	10
			
		@ ERROR MESSAGES
			szInvInput:	.asciz	"*** INVALID NUMERIC STRING. RE-ENTER VALUE ***"
			szVInput:	.asciz	"*** OVERFLOW OCCURRED. RE-ENTER VALUE ***"
			szVAdd:		.asciz	"*** OVERFLOW OCCURRED WHEN ADDING ***"
			szVMul:		.asciz	"*** OVERFLOW OCCURRED WHEN MULTIPLYING ***"
			szDivZero:	.asciz	"*** You cannot divide by 0. Thus, there is NO quotient or remainder ***"
			
		@ STRINGS VALUES OF NUM AND CALCULATIONS FOR INPUT/OUTPUT
			szBuffer:	.skip	12		@ buffer for input
			szSum:		.skip 	12		@ string value of sum
			szDif:		.skip 	12		@ string value of difference
			szPro:		.skip 	12		@ string value of product
			szQuo:		.skip 	12		@ string value of quotient
			szRem:		.skip 	12		@ string value of remainder			

		@ INTEGER VALUES OF NUM AND CALCULATIONS FOR PROCESSING
			iNum1:		.word	0		@ int value of num1
			iNum2:		.word	0		@ int value of num2
			iSum:		.word	0		@ int value of sum
			iDif:		.word	0		@ int value of difference
			iPro:		.word	0		@ int value of product
			iQuo:		.word	0		@ int value of quotient
			iRem:		.word	0		@ int value of remainder

.text

.global _start 							@ Provide program starting address to Linker
		
_start:	

		/************************
		 ** PRINT CLASS HEADER **
		 ************************/
			ldr		r0, =crCr			@ Load into r0 the address of crCr
			bl		putch				@ Call putch macro to output newline
			
			ldr 	r0, =szName			@ Load into r0 the address of szName
			bl 		putstring			@ Call putstring macro to output
			ldr		r0, =crCr			@ Load into r0 the address of crCr
			bl		putch				@ Call putch macro to output newline
			
			ldr 	r0, =szProg			@ Load into r0 the address of szProg
			bl 		putstring			@ Call putstring macro to output
			ldr		r0, =crCr			@ Load into r0 the address of crCr
			bl		putch				@ Call putch macro to output newline
			
			ldr 	r0, =szClass		@ Load into r0 the address of szClass
			bl 		putstring			@ Call putstring macro to output
			ldr		r0, =crCr			@ Load into r0 the address of crCr
			bl		putch				@ Call putch macro to output newline
			
			ldr 	r0, =szDate			@ Load into r0 the address of szDate
			bl 		putstring			@ Call putstring macro to output
			ldr		r0, =crCr			@ Load into r0 the address of crCr
			bl		putch				@ Call putch macro to output newline
			ldr		r0, =crCr			@ Load into r0 the address of crCr
			bl		putch				@ Call putch macro to output		
			

		/************************************
		 ** PROMPT USERS FOR 2 INTS INPUTS **
		 ************************************/		
num1_in:	
			/** Clear the buffer **/
			ldr		r0, =szBuffer		@ Load into r0 the address of szBuffer
			mov		r1, #0				@ r1 = 0
			str		r1, [r0, #0]		@ Store 0 into r0[0]
		
			/** Get input **/
			ldr 	r0, =szNum1Pr		@ Load into r0 the address of szNum1Pr
			bl 		putstring			@ Call putstring macro to output: "Enter your first number: "
			ldr 	r0, =szBuffer		@ Load into r0 the address of szBuffer			
			mov 	r1, #12				@ Dictates maximum bytes in buffer
			bl 		getstring			@ Call getstring macro to get string input for szBuffer			
			
			/** Check if input is null **/
			ldr 	r0, [r0, #0]		@ Load the value of r0
			cmp 	r0, #0				@ Compare r0 and null char
			beq		_end				@ Branch to _end if first character == null
			
			/** Convert string to int **/
			ldr 	r0, =szBuffer		@ Load into r0 the address of szBuffer
			bl		ascint32			@ Convert ascii into an integer		
			ldr		r1,	=iNum1			@ Load into r1 the address of iNum1
			str		r0, [r1]			@ Store the value in r0 to the memory address at [r1]
			
			bcs		inv_input_1			@ Branch to inv_input_1 if   Carry Flag C == 1 (invalid numeric string)
			bvs		oV_input_1			@ Branch to oV_input_2 if oVerflow Flag V == 1 (input overflowed)			
			
num2_in:	
			/** Clear the buffer **/
			ldr		r0, =szBuffer		@ Load into r0 the address of szBuffer
			mov		r1, #0				@ r1 = 0
			str		r1, [r0, #0]		@ Store 0 into r0[0]

			/** Get input **/
			ldr 	r0, =szNum2Pr		@ Load into r0 the address of szNum2Pr
			bl 		putstring			@ Call putstring macro to output: "Enter your second number: "
			ldr 	r0, =szBuffer		@ Load into r0 the address of szBuffer			
			mov 	r1, #12				@ Dictates maximum bytes in buffer
			bl 		getstring			@ Call getstring macro to get string input for szNum2	
			
			/** Check if input is null **/
			ldr 	r0, [r0, #0]		@ Load the value of r0
			cmp 	r0, #0				@ Compare r0 and null char
			beq		_end				@ Branch to _end if first character == null
			
			/** Convert string to int **/
			ldr 	r0, =szBuffer		@ Load into r0 the address of szNum2
			bl		ascint32			@ Convert ascii into an integer		
			ldr		r1,	=iNum2			@ Load into r1 the address of iNum2
			str		r0, [r1]			@ Store the value in r0 to the memory address at [r1]
			bcs		inv_input_2			@ Branch to inv_input_2 if   Carry Flag C == 1 (invalid numeric string)
			bvs		oV_input_2			@ Branch to oV_input_2 if oVerflow Flag V == 1 (input overflowed)		
			
			b		cont_1				@ Branch to continue			
			
		/**************************************
		 ** ERROR MESSAGES FOR INVALID INPUT **
		 **************************************/
inv_input_1:
			ldr		r0, =szInvInput		@ Load into r0 the address of szSum
			bl		putstring			@ Call putch macro to output  
			ldr		r0, =crCr			@ Load into r0 the address of crCr
			bl		putch				@ Call putch macro to output
			b		num1_in
			
oV_input_1:
			ldr		r0, =szVInput		@ Load into r0 the address of szSum
			bl		putstring			@ Call putch macro to output  
			ldr		r0, =crCr			@ Load into r0 the address of crCr
			bl		putch				@ Call putch macro to output
			b		num1_in
			
inv_input_2:
			ldr		r0, =szInvInput		@ Load into r0 the address of szSum
			bl		putstring			@ Call putch macro to output  
			ldr		r0, =crCr			@ Load into r0 the address of crCr
			bl		putch				@ Call putch macro to output
			b		num2_in	
			
oV_input_2:
			ldr		r0, =szVInput		@ Load into r0 the address of szSum
			bl		putstring			@ Call putch macro to output  
			ldr		r0, =crCr			@ Load into r0 the address of crCr
			bl		putch				@ Call putch macro to output
			b		num2_in	

cont_1:
			ldr		r0, =crCr			@ Load into r0 the address of crCr
			bl		putch				@ Call putch macro to output newline
		
		/*******************************
		 ** RETRIEVE VALUES OF 2 INTS **
		 *******************************/
			ldr 	r2, =iNum1			@ Load into r1 the address of iNum1
			ldr 	r2, [r2]			@ Load the value of iNum1			
			ldr 	r3, =iNum2			@ Load into r2 the address of iNum2
			ldr 	r3, [r3]			@ Load the value of iNum2	 		
		 
		 /********************
		 ** SUM OPERATIONS **
		 ********************/							
			adds 	r5, r2, r3			@ r5 = r2 + r3
			bvs		add_oV				@ Branch to add_oV if V == 1 (signed overflow)
			
			/** Store into its integer varible **/
			ldr 	r4, =iSum			@ Load into r4 the address of iSum
			str 	r5, [r4]			@ Store the value in r5 to the memory address at [r4] 
			
			/** Store into its string varible **/
			mov		r0, r5				@ Load into r0 the value of iSum
			ldr		r1, =szSum			@ Load into r1 the address of szSum
			bl		intasc32			@ Convert integer to ascii
			
			/** Output result **/
			ldr		r0, =szSumPr		@ Load into r0 the address of szSumPr
			bl		putstring			@ Call putch macro to output  			
			ldr		r0, =szSum			@ Load into r0 the address of szSum
			bl		putstring			@ Call putch macro to output  
			ldr		r0, =crCr			@ Load into r0 the address of crCr
			bl		putch				@ Call putch macro to output  
			b		cont_2
											
add_oV:			
			ldr		r0, =szVAdd			@ Load into r0 the address of szDivZero
			bl		putstring			@ Call putch macro to output  
			ldr		r0, =crCr			@ Load into r0 the address of crCr
			bl		putch				@ Call putch macro to output											
											
		/***************************
		 ** DIFFERENCE OPERATIONS **
		 ***************************/							
cont_2:		
			sub 	r5, r2, r3			@ r5 = r2 - r3
			
			/** Store into its integer varible **/
			ldr 	r4, =iDif			@ Load into r4 the address of iDif
			str 	r5, [r4]			@ Store the value in r5 to the memory address at [r4]
			
			/** Store into its string varible **/
			mov		r0, r5				@ Load into r0 the value of iDif
			ldr		r1, =szDif			@ Load into r1 the address of szDif
			bl		intasc32			@ Convert integer to ascii
			
			/** Output result **/
			ldr		r0, =szDifPr		@ Load into r0 the address of szDifPr
			bl		putstring			@ Call putch macro to output  			
			ldr		r0, =szDif			@ Load into r0 the address of szDif
			bl		putstring			@ Call putch macro to output  
			ldr		r0, =crCr			@ Load into r0 the address of crCr
			bl		putch				@ Call putch macro to output  
			
		/************************
		 ** PRODUCT OPERATIONS **
		 ************************/	
			smull	r5, ip, r2, r3		@ r5 = r2 * r3
			cmp		ip, r5, ASR #31		@ Branch to mul_oV if V == 1 (signed ovrflow)
			bne		mul_oV
			
			/** Store into its integer varible **/
			ldr 	r4, =iPro			@ Load into r4 the address of iPro
			str 	r5, [r4]			@ Store the value in r5 to the memory address at [r4]
			
			/** Store into its string varible **/
			mov		r0, r5				@ Load into r0 the value of iPro
			ldr		r1, =szPro			@ Load into r1 the address of szPro
			bl		intasc32			@ Convert integer to ascii	
			
			/** Output result **/
			ldr		r0, =szProPr		@ Load into r0 the address of szProPr
			bl		putstring			@ Call putch macro to output  			
			ldr		r0, =szPro			@ Load into r0 the address of szPro
			bl		putstring			@ Call putch macro to output  
			ldr		r0, =crCr			@ Load into r0 the address of crCr
			bl		putch				@ Call putch macro to output 
			
			cmp		r3, #0				@ Compare r3 and 0
			beq		div_zero_out		@ Branch to div_zero_out if r3 == 0
			b		cont_3				@ Branch to cont_3
			
mul_oV:			
			ldr		r0, =szVMul			@ Load into r0 the address of szDivZero
			bl		putstring			@ Call putch macro to output  
			ldr		r0, =crCr			@ Load into r0 the address of crCr
			bl		putch				@ Call putch macro to output			
		
		/*************************
		 ** QUOTIENT OPERATIONS **
		 *************************/		
cont_3:
			sdiv	r5, r2, r3			@ r5 = r2 / r3
			
			/** Store into its integer varible **/
			ldr 	r4, =iQuo			@ Load into r4 the address of iQuo
			str 	r5, [r4]			@ Store the value in r5 to the memory address at [r4]
			
			/** Store into its string varible **/
			mov		r0, r5				@ Load into r0 the value of iQuo
			ldr		r1, =szQuo			@ Load into r1 the address of szQuo
			bl		intasc32			@ Convert integer to ascii
			
			/** Output result **/
			ldr		r0, =szQuoPr		@ Load into r0 the address of szQuoPr
			bl		putstring			@ Call putch macro to output  			
			ldr		r0, =szQuo			@ Load into r0 the address of szQuo
			bl		putstring			@ Call putch macro to output  
			ldr		r0, =crCr			@ Load into r0 the address of crCr
			bl		putch				@ Call putch macro to output 
			
		/**************************
		 ** REMAINDER OPERATIONS **
		 **************************/	
			sdiv	r7, r2, r3			@ r7 = r2 / r3		a = b/c
			mul		r8, r7, r3			@ r8 = r7 * r3		d = a*c
			sub		r5, r2, r8			@ r5 = r2 - r8		r = b-d
			
			/** Store into its integer varible **/
			ldr 	r4, =iRem			@ Load into r4 the address of iRem
			str 	r5, [r4]			@ Store the value in r5 to the memory address at [r4]
			
			/** Store into its string varible **/
			mov		r0, r5				@ Load into r0 the value of iRem
			ldr		r1, =szRem			@ Load into r1 the address of szRem
			bl		intasc32			@ Convert integer to ascii		
			
			/** Output result **/
			ldr		r0, =szRemPr		@ Load into r0 the address of szRemPr
			bl		putstring			@ Call putch macro to output  			
			ldr		r0, =szRem			@ Load into r0 the address of szRem
			bl		putstring			@ Call putch macro to output  
			ldr		r0, =crCr			@ Load into r0 the address of crCr
			bl		putch				@ Call putch macro to output
			
			b 		next_run			@ Branch to next run
	
div_zero_out:			
			ldr		r0, =szDivZero		@ Load into r0 the address of szDivZero
			bl		putstring			@ Call putch macro to output  
			ldr		r0, =crCr			@ Load into r0 the address of crCr
			bl		putch				@ Call putch macro to output
			
next_run:				
			ldr		r0, =crCr			@ Load into r0 the address of crCr
			bl		putch				@ Call putch macro to output
			ldr		r0, =szBorder		@ Load into r0 the address of szDivZero
			bl		putstring			@ Call putch macro to output  
			ldr		r0, =crCr			@ Load into r0 the address of crCr
			bl		putch				@ Call putch macro to output
			ldr		r0, =crCr			@ Load into r0 the address of crCr
			bl		putch				@ Call putch macro to output
			
			b		num1_in				@ Branch to num1_in
		
		/*****************
		 ** END PROGRAM **
		 *****************/		 
_end:		
			ldr		r0, =crCr			@ Load into r0 the address of crCr
			bl		putch				@ Call putch macro to output
			ldr		r0, =szEnd			@ Load into r0 the address of szEnd
			bl		putstring			@ Call putch macro to output  
			ldr		r0, =crCr			@ Load into r0 the address of crCr
			bl		putch				@ Call putch macro to output  	

			mov 	r0, #0				@ Exit Status code set to 0 indicates "normal completion"
			mov 	r7, #1 				@ Service command code (1) will terminate this program
			svc 	0      				@ Issue Linux command to terminate program
		
			.end

