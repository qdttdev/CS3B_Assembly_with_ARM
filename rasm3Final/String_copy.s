@;//////////////////////////////////////////////////////////////////////
@;// Subroutine String_copy accepts the addresses of a string into R0 //
@;// and returns a copy of the string into r0						  //
@;//    R0: Points to first byte of the first string				  //
@;//    LR: Contains the return address								  //
@;//																  //
@;// Returned register contents:									  //
@;//    R0: Returns a copy of the inputted string					  //
@;//  All registers are preserved as per AAPCS						  //
@;//////////////////////////////////////////////////////////////////////

.data
		szDesStr:	.skip 512		
		
.global	String_copy						@; Subroutine entry point
		
String_copy:

		/** AAPCS: A subroutine (callee) must preserve the contents **/
		/** of the registers r4-r8, r10, r11 **/
		stmdb 	sp!, {r4-r8,r10,r11,lr} @; Push r4-r8, r10, r11, and lr onto the stack
		
		@; ldr r0, =szStr1				@; Load into r0 the address of szStr1
				
		ldr 	r1, =szDesStr			@; Load into r2 the address of szDesStr
		mov 	r2, #0					@; Initialize index: i = 0
		
Loop:	/** Saving value into r0 **/		
		ldrb	r3, [r0, r2]			@; Load r0[i] into r3
		strb	r3, [r1, r2]			@; Store r3 into r1[i]
		add		r2, r2, #1				@; Increment: i++
		cmp		r3, #0					@; Compare if r3 == NULL
		bne		Loop					@; Branch to Loop if r3 != NULL

end:
		ldr 	r0, =szDesStr			@; Load into r0 the address of szDesStr
		ldmia 	sp!, {r4-r8,r10,r11,lr} @; Pop r4-r8, r10, r11 and lr from the stack 			
		bx		lr						@; Return to the calling program
		
		.end							@; End function
