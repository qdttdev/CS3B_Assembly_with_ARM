@;//////////////////////////////////////////////////////////////////////
@;// Subroutine String_startsWith_1 accepts the address of a string,  //
@;// position index, address of compare string into r0, r1, r2.		  //
@;//    R0: Points to first byte of the first string				  //
@;//	R1: Contains the position index								  //
@;//	R2: Points to first byte of the string to compare			  //
@;//    LR: Contains the return address								  //
@;//																  //
@;// Returned register contents:									  //
@;//    R0: Returns 1 if TRUE  - Strings are equal					  //
@;//	  	Returns 0 if FALSE - Strings are not equal				  //
@;//  All registers are preserved as per AAPCS						  //
@;//////////////////////////////////////////////////////////////////////

.global	String_startsWith_1				@; Subroutine entry point
		
String_startsWith_1:

		/** AAPCS: A subroutine (callee) must preserve the contents **/
		/** of the registers r4-r8, r10, r11 **/
		stmdb 	sp!, {r4-r8,r10,r11,lr} @; Push r4-r8, r10, r11, and lr onto the stack
				
		@; ldr r0, =szStr1				@; Load into r0 the address of szStr1
		@; mov r1, #11					@; Position index: r1 = 11
		@; ldr r2, =szTest10			@; Load into r2 the address of szTest10
				
		mov 	r10, r0					@; Make copy of address from r0 to r10 (szStr1)
		mov 	r11, r2					@; Make copy of address from r2 to r11 (szTest10)
		mov 	r8, r1					@; Make copy of position index r8: i = r1
		
		mov 	r5, #0					@; Initialize index: j = 0
Loop1:
		ldrb	r6, [r10, r8]			@; r6 = szStr1[r8] (from i = 11..14) 
		ldrb	r7, [r11, r5]			@; r7 = szTest10[r5] (from j = 0..3)
		cmp		r6, r7					@; Compare if szStr1[i] == szTest10[j]
		bne		end_F					@; End: Returns False
		add		r8, r8, #1 				@; Incr index: i++
		add		r5, r5, #1				@; Incr index: j++
		cmp		r6, #0					@; Compare if == null terminated character
		beq		end_T					@; Exit Loops at r6 = null; Returns True
		b		Loop1					@; Branch to Loop1
				
end_T:	
		mov		r0, #1					@; Returns True == 1
		b		end						@; Branch to end
		
end_F:		
		mov		r0, #0					@; Returns False == 0
		b		end						@; Branch to end
end:
		ldmia 	sp!, {r4-r8,r10,r11,lr} @; Pop r4-r8, r10, r11 and lr from the stack 			
		bx		lr						@; Return to the calling program
		
		.end							@; End function
