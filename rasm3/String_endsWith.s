@;//////////////////////////////////////////////////////////////////////
@;// Subroutine String_endsWith accepts the address of a string and   //
@;// address of compare string into r0, r1 accordingly.				  //
@;//    R0: Points to first byte of the first string				  //
@;//	R1: Points to first byte of the compare string				  //
@;//    LR: Contains the return address								  //
@;//																  //
@;// Returned register contents:									  //
@;//    R0: Returns 1 if TRUE  - Strings are equal					  //
@;//	  	Returns 0 if FALSE - Strings are not equal				  //
@;//  All registers are preserved as per AAPCS						  //
@;//////////////////////////////////////////////////////////////////////

.data

.global	String_endsWith					@; Subroutine entry point
		
String_endsWith:

		/** AAPCS: A subroutine (callee) must preserve the contents **/
		/** of the registers r4-r8, r10, r11 **/
		stmdb 	sp!, {r4-r8,r10,r11,lr} @; Push r4-r8, r10, r11, and lr onto the stack
				
		@; ldr r0, =szStr1				@; Load into r0 the address of szStr1
		@; ldr r1, =szTest12			@; Load into r1 the address of szTest12
				
		mov r10, r0						@; Make copy of address from r0 to r10 (szStr1)
		mov r11, r1						@; Make copy of address from r1 to r11 (szTest12)		
		
		/** Calculate length of szStr1 **/
		mov r0, r10						@; Make copy of address from r10 to r0
		mov		r1, #0					@; Initialize index: r1 = 0			
Loop_a:		
		ldrb	r2, [r0, r1]			@; Load into r2 the first byte r0[r1]
		add		r1, r1, #1 				@; Increment index: r1++
		teq		r2, #0					@; Compare if == Null terminated string
		bne		Loop_a					@; If != 0, branch to loop again			
next_a:		
		sub		r1, r1, #1				@; r1 = r1-1 (decrement for null terminated)
		mov		r0, r1					@; r0 = r1
				
		/** Store length of szStr1 **/				
		mov r7, r0						@; r7 = szStr1.String_length()
		sub r7, r7, #1					@; r7 = i = Last index of szStr1
		
		
		/** Calculate length of szTest12 **/
		mov r0, r11						@; Make copy of address from r11 to r0
		mov		r1, #0					@; Initialize index: r1 = 0			
Loop_b:		
		ldrb	r2, [r0, r1]			@; Load into r2 the first byte r0[r1]
		add		r1, r1, #1 				@; Increment index: r1++
		teq		r2, #0					@; Compare if == Null terminated string
		bne		Loop_b					@; If != 0, branch to loop again			
next_b:		
		sub		r1, r1, #1				@; r1 = r1-1 (decrement for null terminated)
		mov		r0, r1					@; r0 = r1
			
		/** Store length of szTest12 **/		
		mov r8, r0						@; r8 = szTest11.String_length()
		sub r6, r8, #1					@; r6 = j = Last index of szTest12
		
				
		/** Determine if szStr1 ends with szTest12 **/
Loop1:
		ldrb	r5, [r10, r7]			@; r6 = szStr1[i] 
		ldrb	r4, [r11, r6]			@; r7 = szTest12[j]  
		cmp		r5, r4					@; Compare if szStr1[i] == szTest12[j]
		bne		end_F					@; End: Returns False
		sub		r7, r7, #1				@; Decrement index: i--
		sub		r6, r6, #1				@; Decrement index: j--		
		cmp		r6, #0					@; Compare if j == 0
		beq		end_T					@; Then Exit Loops at j = null; Returns True
		b		Loop1					@; Else Branch to Loop1	
				
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
