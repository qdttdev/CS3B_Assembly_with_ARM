@ Name: 	Caroline Ta
@ Program: 	Lab 13 (EC)
@ Date: 	03-11-2020

@ This program takes input of an integer and print the Collatz Sequence
@ and the number of steps (iterations) that it takes to get to 1.

.data
		@ VARIABLES
			iNum:		.word 	0
			szNum:		.skip	12
			crCr:		.byte 	10
			szInput:	.asciz	"Enter number: "
			szStepNum:	.asciz	"Number of steps (excluding 1): "
			szSteps:	.asciz	"Steps: "
			szSpace:	.asciz	" "

.text

.global _start

_start:

	/*********************************
	 ** OUTPUT PROMPT AND GET INPUT **
	 *********************************/
	ldr		r0, =szInput		@ Load into r0 the address of szInput				
	bl		putstring			@ Call putch macro to output  szInput
	
	ldr 	r0, =szNum			@ Load into r0 the address of szNum			
	mov 	r1, #12				@ Dictates maximum bytes in buffer
	bl 		getstring			@ Call getstring macro to get string input for szNum														
						
	/*****************************************
	 ** CONVERT STRING INPUTS INTO INTEGERS **
	 *****************************************/
	ldr 	r0, =szNum			@ Load into r0 the address of szNum
	bl		ascint32			@ Convert ascii into an integer		
	ldr		r9,	=iNum			@ Load into r9 the address of iNum
	str		r0, [r9]			@ Store the value in r0 to the memory address at [r9]

	ldr 	r9, [r9]			@ Load value of r9
	mov 	r2, #0				@ r2 <- 0 the # of steps
	
	ldr		r0, =crCr			@ Load into r0 the address of crCr
	bl		putch				@ Call putch macro to output newline
		
	ldr		r0, =szSteps		@ Load into r0 the address of szOutput				
	bl		putstring			@ Call putch macro to output  szOutput

loop:	

	/******************
	 ** OUTPUT STEPS **
	 ******************/			
	mov		r0, r9				@ Load into r0 the address of iNum
	ldr		r1, =szNum			@ Load into r1 the address of szNum			
	bl		intasc32			@ Convert integer into ascii
	
	ldr		r0, =szNum			@ Load into r0 the address of szNum				
	bl		putstring			@ Call putch macro to output  szNum
	
	ldr		r0, =szSpace		@ Load into r0 the address of szSpace
	bl		putstring			@ Call putch macro to output szSpace
	
	/*******************************
	 ** CHECK IF n IS ODD OR EVEN **
	 *******************************/
	cmp 	r9, #1				@ Compare r1 vs. 1 
	beq 	end					@ branch to end if r1 == 1
	
	and 	r3, r9, #1			@ r3 <- r1 & 1 [mask]	
	cmp 	r3, #0				@ compare r3 and 0
	bne 	odd					@ branch to odd  if r3 != 0
	beq		even				@ branch to even if r3 == 0
	
even: 	/** If n is even, then n = n / 2 **/

	mov		r9, r9, ASR #1		@ r1 <- (r1 >> 1) [divided by 2]
	b		end_loop
	
odd:	/** If n is odd, then n = 3*n + 1 **/
	
	add r9, r9, r9, LSL #1		@ r1 <- r1 + (r1 << 1) [3n]
	add r9, r9, #1				@ r1 <- r1 + 1 [3n+1]
	
end_loop:

	add 	r2, r2, #1			@ r2 <- r2 + 1
	b		loop				@ branch to loop

end:

	/****************************
	 ** OUTPUT NUMBER OF STEPS **
	 ****************************/
	ldr		r0, =crCr			@ Load into r0 the address of crCr
	bl		putch				@ Call putch macro to output newline
	 
	ldr		r0, =crCr			@ Load into r0 the address of crCr
	bl		putch				@ Call putch macro to output newline
				
	ldr		r0, =szStepNum		@ Load into r0 the address of szSpace
	bl		putstring			@ Call putch macro to output szSpace
	 		
	mov		r0, r2				@ Load into r0 the address of iNum
	ldr		r1, =szNum			@ Load into r1 the address of szNum			
	bl		intasc32			@ Convert integer into ascii
	
	ldr		r0, =szNum			@ Load into r0 the address of szNum				
	bl		putstring			@ Call putch macro to output  szNum
	
	ldr		r0, =szSpace		@ Load into r0 the address of szSpace
	bl		putstring			@ Call putch macro to output szSpace
	
	ldr		r0, =crCr			@ Load into r0 the address of crCr
	bl		putch				@ Call putch macro to output newline
	
	
	/*****************
	 ** END PROGRAM **
	 *****************/	
	mov 	r0, #0				@ Exit Status code set to 0 indicates "normal completion"
	mov 	r7, #1 				@ Service command code (1) will terminate this program
	svc 	0      				@ Issue Linux command to terminate program

	.end
