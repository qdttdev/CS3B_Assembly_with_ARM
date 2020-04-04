@;//////////////////////////////////////////////////////////////////////
@;// Subroutine String_startsWith_2 accepts the address of a string   //
@;// and address of compare string into r0, r1 accordingly.			  //
@;//    R0: Points to first byte of the first string				  //
@;//	R1: Points to first byte of the compare string				  //
@;//    LR: Contains the return address								  //
@;//																  //
@;// Returned register contents:									  //
@;//    R0: Returns 1 if TRUE  - Strings are equal					  //
@;//	  	Returns 0 if FALSE - Strings are not equal				  //
@;//  All registers are preserved as per AAPCS						  //
@;//////////////////////////////////////////////////////////////////////

.global	String_startsWith_2				@; Subroutine entry point
		
String_startsWith_2:

		/** AAPCS: A subroutine (callee) must preserve the contents **/
		/** of the registers r4-r8, r10, r11 **/
		stmdb 	sp!, {r4-r8,r10,r11,lr} @; Push r4-r8, r10, r11, and lr onto the stack
				
		@; ldr r0, =szStr1
		@; ldr r1, =szTest11		
				
		mov r10, r0						@; Make copy of address from r0 to r10 (szStr1)
		mov r11, r1						@; Make copy of address from r1 to r11 (szTest11)		
		
		/** Calculate the length of szTest11 **/
		mov 	r0, r1					@; r0 = r1
		mov		r1, #0					@; Initialize index: r1 = 0			
Loop:		
		ldrb	r2, [r0, r1]			@; Load into r2 the first byte r0[r1]
		add		r1, r1, #1 				@; Increment index: r1++
		teq		r2, #0					@; Compare if == Null terminated string
		bne		Loop					@; If != 0, branch to loop again			
next:		
		sub		r1, r1, #1				@; r1 = r1-1 (decrement for null terminated)
		mov		r0, r1					@; r0 = r1
		
		/** Store the length of szTest11 **/			
		mov r8, r0						@; r8 = szStr.String_Length()
		
		mov r5, #0						@; Initialize index: i = 0
		
Loop1:
		ldrb	r6, [r10, r5]			@; r6 = szStr1[r5] 
		ldrb	r7, [r11, r5]			@; r7 = szTest11[r5]  
		cmp		r6, r7					@; Compare if szStr1[i] == szSzTest11[i]
		bne		end_F					@; End: Returns False
		add		r5, r5, #1				@; Incr index: i++
		cmp		r5, r8					@; Compare if r5 == szTest11.String_Length()
		beq		end_T					@; Then Exit Loop
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

