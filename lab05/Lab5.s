/* -- Lab5.s */

.data
szMsg1:	.asciz "The sun did not shine."
szMsg2:	.asciz "It was too wet to play."
crCr:	.byte 10

.text
	
		.global _start	@ Provide program starting address to linker

_start:
		ldr r0, =szMsg1 @ Load into r0 the address of szMsg1
		bl putstring	@ Call putstring from macro
		
		ldr r0, =crCr	@ Load into r0 the address of crCr
		bl putch		@ Call putch from macro
		
		ldr r0, =szMsg2 @ Load into r0 the address of szMsg2
		bl putstring	@ Call putstring from macro
		
		ldr r0, =crCr	@ Load into r0 the address of crCr
		bl putch		@ Call putch from macro
		
		mov r0, #0		@ Exit Status code set to 0 indicates "normal completion"
		mov r7, #1 		@ Service command code (1) will terminate this program
		svc 0      		@ Issue Linux command to terminate program
		
		.end

