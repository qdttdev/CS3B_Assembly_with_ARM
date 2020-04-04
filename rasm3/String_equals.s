@;/////////////////////////////////////////////////////////////////////////////
@;// Subroutine String_equals accepts the addresses of two strings into R0,  //
@;// R1 accordingly, compare two strings and returns a boolean expression.   //
@;//    R0: Points to first byte of the first string						 //
@;//	  R1: Points to first byte of the second string						 //
@;//    LR: Contains the return address										 //
@;//																		 //
@;// Returned register contents:											 //
@;//    R0: Returns 1 if TRUE  - Strings are equal							 //
@;//		  Returns 0 if FALSE - Strings are not equal					 //
@;// All registers are preserved as per AAPCS								 //
@;/////////////////////////////////////////////////////////////////////////////
		
		.global	String_equals			@; Subroutine entry point
		
String_equals:

		/** AAPCS: A subroutine (callee) must preserve the contents **/
		/** of the registers r4-r8, r10, r11 **/
		stmdb 	sp!, {r4-r8,r10,r11,lr} @; Push r4-r8, r10, r11, and lr onto the stack
		
		@; ldr r0, =szStr1				@; Load into r0 the address of szString1
		@; ldr r1, =szStr2				@; Load into r1 the address of szString2
		
		mov r2, r0						@; Make copy of address from r0 to r2
		mov	r3, r1						@; Make copy of address from r1 to r3
		
		mov r8, #0						@; Initialize r8: i = 0
		
cont_1:		
		ldrb	r6, [r2, r8]			@; r6 = szStr1[i]
		ldrb	r7, [r3, r8]			@; r7 = szStr2[i]
		cmp		r6, r7					@; Compare if szStr1[i] == szStr2[i]
		bne		end_F					@; End: Returns False
		add		r8, r8, #1 				@; Incr index: i++
		cmp		r6, #0					@; Compare if == null terminated character
		beq		end_T					@; Exit Loops at r11 = 0; Returns True
		b		cont_1
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
