@;//////////////////////////////////////////////////////////////////////
@;// Subroutine String_charAt accepts the addresses of a string  	  //
@;// and begin index into r0, r1 accordingly.			  			  //
@;//    R0: Points to first byte of the first string				  //
@;//	R1: Contains the position index								  //
@;//    LR: Contains the return address								  //
@;//																  //
@;// Returned register contents:									  //
@;//    R0: Returns a character of the inputted string				  //
@;//  All registers are preserved as per AAPCS						  //
@;//////////////////////////////////////////////////////////////////////
		
.data			
		.global	String_charAt			@; Subroutine entry point
		
String_charAt:

		/** AAPCS: A subroutine (callee) must preserve the contents **/
		/** of the registers r4-r8, r10, r11 **/
		stmdb 	sp!, {r4-r8,r10,r11,lr} @; Push r4-r8, r10, r11, and lr onto the stack
		
		@; ldr r0, =szStr2				@; Load into r0 the address of szStr2
		@; mov r1, #4					@; Position index: r1 = 4
				
		mov r10, r0						@; Make copy of address from r0 into r10		
		mov r11, r1						@; r11 = position index
		
		
Loop:	/** Saving value into r0 **/
		ldrb	r0, [r10, r11]			@; Load r10[r11] into r0

end:
		ldmia 	sp!, {r4-r8,r10,r11,lr} @; Pop r4-r8, r10, r11 and lr from the stack 			
		bx		lr						@; Return to the calling program
		
		.end							@; End function
