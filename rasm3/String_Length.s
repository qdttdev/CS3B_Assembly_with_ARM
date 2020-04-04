@;////////////////////////////////////////////////////////////////////////////
@;// Subroutine String_Length accepts the address of a string and counts 	//
@;// the characters in the string, excluding the NULL character and returns //
@;// that value as an int (word) in the R0 register. will read a string of 	//
@;// characters terminated by a null										//
@;//    R0: Points to first byte of string to count							//
@;//    LR: Contains the return address										//
@;//																		//
@;// Returned register contents:											//
@;//   	R0: Number of characters in the string (does not include null).		//
@;// All registers are preserved as per AAPCS								//
@;////////////////////////////////////////////////////////////////////////////
		
.global	String_Length						@; Subroutine entry point
		
String_Length:
		
			/** AAPCS: A subroutine (callee) must preserve the contents **/
			/** of the registers r4-r8, r10, r11 **/
			stmdb 	sp!, {r4-r8,r10,r11,lr} @; Push r4-r8, r10, r11, and lr onto the stack			
			
			mov		r1, #0					@; Initialize index: r1 = 0
			
Loop:		
			ldrb	r2, [r0, r1]			@; Load into r2 the first byte r0[r1]
			add		r1, r1, #1 				@; Increment index: r1++
			teq		r2, #0					@; Compare if == Null terminated string
			bne		Loop					@; If != 0, branch to loop again
			
_end:		
			sub		r1, r1, #1				@; r1 = r1-1 (decrement for null terminated)
			mov		r0, r1					@; r0 = r1
			
			ldmia 	sp!, {r4-r8,r10,r11,lr} @; Pop r4-r8, r10, r11 and lr from the stack 
			
			bx		lr						@; Return to the calling program
			
			.end
