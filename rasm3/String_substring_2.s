@;//////////////////////////////////////////////////////////////////////
@;// Subroutine String_substring_2 accepts the addresses of a string  //
@;// and begin index into r0, r1 accordingly.			  			  //
@;//    R0: Points to first byte of the first string				  //
@;//	R1: Contains the begin index								  //
@;//    LR: Contains the return address								  //
@;//																  //
@;// Returned register contents:									  //
@;//    R0: Returns a substring of the inputted string				  //
@;//  All registers are preserved as per AAPCS						  //
@;//////////////////////////////////////////////////////////////////////		

.data
		szDesStr:	.skip 512		
		
		.global	String_substring_2		@; Subroutine entry point
		
String_substring_2:

		/** AAPCS: A subroutine (callee) must preserve the contents **/
		/** of the registers r4-r8, r10, r11 **/
		stmdb 	sp!, {r4-r8,r10,r11,lr} @; Push r4-r8, r10, r11, and lr onto the stack
		
		@; ldr		r0, =szStr3			@; Load into r0 the address of szStr3
		@; mov		r1, #7				@; Begin index: r1 = 7
		
		mov r10, #0						@; Contains j index: j = 0
		mov r11, r1						@; Contains begin index: i = r1
		
		ldr r2, =szDesStr				@; Load into r2 the address of szDesStr
		
Loop:	/** Saving value into r0 **/
		ldrb	r4, [r0, r11]			@; Load r0[r11] into r4
		strb	r4, [r2, r10]			@; Store r4 into r2[r10]
		add		r11, r11, #1			@; Increment r11: i++
		add		r10, r10, #1			@; Increment r10: j++
		cmp		r4, #0					@; Compare if r4 == NULL
		bne		Loop					@; Branch to Loop if r4 != NULL

end:
		ldr 	r0, =szDesStr			@; Load into r0 the address of szDesStr
		ldmia 	sp!, {r4-r8,r10,r11,lr} @; Pop r4-r8, r10, r11 and lr from the stack 			
		bx		lr						@; Return to the calling program
		
		.end							@; End function
