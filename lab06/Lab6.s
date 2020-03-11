/* -- Lab6.s */

.data
szX:	.asciz	"10"
szY:	.asciz	"15"
iX:		.word	0
iY:		.word	0
iSum:	.word	0

.text

		.global _start 		@ Provide program starting address to Linker
		
_start:

		@ STORING 10 AS AN INTEGER INTO iX
		ldr 	r0, =szX		@ Load into r0 the address of szX
		mov		r4, r0			@ Copy contents of r0 into r4
		bl		ascint32		@ Converts asciz into an integer		
		ldr		r1,	=iX			@ Load into r1 the address of iX
		str		r0, [r1]		@ Store the value in r0 to the memory address at [r1] @ iX = 10
		
		
		
		@ STORING 15 AS AN INTEGER INTO iY
		ldr 	r0, =szY		@ Load into r0 the address of szY
		mov		r5, r0			@ Copy contents of r0 into r5 
		bl		ascint32		@ Converts asciz into an integer		
		ldr		r1,	=iY			@ Load into r1 the address of iX
		str		r0, [r1]		@ Store the value in r0 to the memory address at [r1] @ iY = 15
		
		
		@ RETRIEVE VALUES OF iX AND iY AND STORE THE SUM INTO iSum 
		ldr 	r0, =iX			@ Load into r0 the address of iX
		ldr 	r0, [r0]		@ Load the value of iX
		
		ldr 	r1, =iY			@ Load into r1 the address of iY
		ldr 	r1, [r1]		@ Load the value of iY
		
		add 	r2, r0, r1		@ Add values of r0 and r1 and store into r2
		
		ldr 	r3, =iSum		@ Load into r3 the address of iSum
		str 	r2, [r3]		@ Store the value in r2 to the memory address at [r3] @iSum = 25
				
		
		mov 	r0, #0			@ Exit Status code set to 0 indicates "normal completion"
		mov 	r7, #1 			@ Service command code (1) will terminate this program
		svc 	0      			@ Issue Linux command to terminate program
		
		.end
		
