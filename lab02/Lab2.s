/* -- Lab2.s */
/* This is a comment */
@ This is also a comment

	.global _start	@ Provide program starting address to Liner

_start:
	mov r0, #0		@ Exit Status code set to 0 indicates "normal completion"
	mov r7, #1 		@ Service command code (1) will terminate this program
	svc 0      		@ Issue Linux command to terminate program

	.end
