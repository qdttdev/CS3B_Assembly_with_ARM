@;//////////////////////////////////////////////////////////////////////
@;// Subroutine String_substring_1 accepts the addresses of a string, //
@;// begin index, end index into r0, r1, r2 accordingly.			  //
@;//    R0: Points to first byte of the first string				  //
@;//	R1: Contains the begin index								  //
@;//	R2: Contains the end   index								  //
@;//    LR: Contains the return address								  //
@;//																  //
@;// Returned register contents:									  //
@;//    R0: Returns a substring of the inputted string				  //
@;//  All registers are preserved as per AAPCS						  //
@;//////////////////////////////////////////////////////////////////////		

.data
		szDesStr:	.skip 512

.global	String_substring_1				@; Subroutine entry point	
		
String_substring_1:

		/** AAPCS: A subroutine (callee) must preserve the contents **/
		/** of the registers r4-r8, r10, r11 **/
		stmdb 	sp!, {r4-r8,r10,r11,lr} @; Push r4-r8, r10, r11, and lr onto the stack
				
		@; ldr		r0, =szStr3			@; Load into r0 the address of szStr3
		@; mov		r1, #4				@; Begin index: r1 = 4
		@; mov		r2, #13				@; End   index: r2 = 13		
		
		sub r3, r2, r1					@; r3 holds number of characters to extract
		mov r4, #0						@; Counter: c = 0
		
		ldr r6, =szDesStr				@; r1 holds the address of szDesStr
		
Loop1:	/** Saving value into r5 **/
		ldrb	r5, [r0, r1] 			@; Load  byte at r0[r1] (srcStr)
		cmp		r5, #0					@; Compare if r5 == NULL
		beq		Loop2					@; Branch to Loop2 if r5 == NULL
		
		strb	r5, [r6, r4]			@; Store byte at r6[r4] (desStr)
		add		r1, r1, #1				@; Increment index: i++			
		add		r4, r4, #1				@; Increment counter: c++
		cmp		r4, r3					@; Compare if c == numExtract
		ble		Loop1					@; Branch to Loop1 if c <= numExtract
		b		end						@; Branch to end
		
Loop2:		
		mov		r5, #0					@; r5 = 0
		strb	r5, [r6, r4]			@; Load byte at r1[r4] (desStr)
		mov		r0, r4					@; r4 = r0
end:	
		ldr r0, =szDesStr				@; Load into r0 the address of szDesStr
		ldmia 	sp!, {r4-r8,r10,r11,lr} @; Pop r4-r8, r10, r11 and lr from the stack 			
		bx		lr						@; Return to the calling program
		
		.end							@; End function
