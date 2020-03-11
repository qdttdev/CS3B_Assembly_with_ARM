/* -- Lab4.s */
@Create the following C++ like arrays in your data segment..
@int iSrcArray[16] = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15};
@int iDestArray[16];

@Use ldm and stm to write a short sequence of ARM assembly language to 
@copy 16 words of data from iSrcArray to iDestArray. Load the iSrcArray 
@address into r0 and iDestArray address into r1. You may use r0 through 
@r5 to hold values if needed. Your code is allowed to modify r0 and/or r1.

.data	@ Data declaration section

	iSrcArray:	.word	0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
	iDestArray:	.skip	64 			@ skip 16*4 bytes

.text	@ Start of code section


.global _start	@ Provide program starting address to Linker

_start:	
	
	ldr			r0,=iSrcArray		@ load into r0 the address of iSrcArray
	ldr			r1,=iDestArray		@ load into r1 the address of iDestArray
	
	ldm			r0!,{r2-r5}			@ load four words from source	
	stm			r1!,{r2-r5}			@ store them in destination
	
	ldm			r0!,{r2-r5}			@ load four words from source	
	stm			r1!,{r2-r5}			@ store them in destination
	
	ldm			r0!,{r2-r5}			@ load four words from source	
	stm			r1!,{r2-r5}			@ store them in destination
	
	ldm			r0!,{r2-r5}			@ load four words from source	
	stm			r1!,{r2-r5}			@ store them in destination
	
	mov r0, #0						@ Exit Status code set to 0 indicates "normal completion"
	mov r7, #1 						@ Service command code (1) will terminate this program
	svc 0      						@ Issue Linux command to terminate program
	
	.end
	
	 

		
