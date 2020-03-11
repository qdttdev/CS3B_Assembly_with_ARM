/***********************************************************************
 * PROGRAMMED BY    :   Caroline Ta
 * STUDENT ID       :   1061262
 * CLASS            :   CS3B (M-W 3.30PM)
 * ASSIGNMENT		:	Lab 9
 **********************************************************************/
/***********************************************************************
 * PURPOSE OF PROGRAM: Familiarize with CPSR Register
 *----------------------------------------------------------------------
 * R0 = add(s)  (iX, iY)	Add
 * R1 = adc 	(iX, iY)	Add with carry
 * R2 = sub(s) 	(iX, iY)	Subtract
 * R3 = sbc 	(iX, iY)	Subtract with carry
 * R4 = rsb 	(iX, iY)	Reverse subtract
 * R5 = rsc 	(iX, iY) 	Reverse subtract with carry
 **********************************************************************/
 

.data
			iX:		.word	0xDEADBEEF
			iY:		.word	0xCAFEBABE

.text
			.global _start 				@ Provide program starting address to Linker
		
_start:		
		
			ldr 	r8, =iX				@ Load into r8 the address of iX
			ldr 	r8, [r8]			@ Load value of iX
			
			ldr 	r9, =iY				@ Load into r9 the address of iY
			ldr 	r9, [r9]			@ Load value of iY
			
			adds 	r0, r8, r9			@ r0 = r8 + r9 & set flags
			
			adc 	r1, r8, r9			@ r1 = r8 + r9 + carry
			
			subs 	r2, r8, r9			@ r2 = r8 - r9 & set flags
			
			sbc		r3, r8, r9			@ r3 = r8 - r9 + carry - 1
			
			rsb		r4, r8, r9			@ r4 = r9 - r8
			
			rsc		r5, r8, r9			@ r5 = r9 - r8 + carry - 1
			
		
		/*****************
		 ** END PROGRAM **
		 *****************/
			mov 	r0, #0				@ Exit Status code set to 0 indicates "normal completion"
			mov 	r7, #1 				@ Service command code (1) will terminate this program
			svc 	0      				@ Issue Linux command to terminate program
		
			.end
