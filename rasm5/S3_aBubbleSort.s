/****************************************************************************
 * Assembly Bubble Sort
 * --------------------------------------------------------------------------
 * R0:	Pointer to the first element of the array
 * R1:	Length of the array
 ***************************************************************************/

.global aBubbleSort

@; Creates an alias for registers with corresponding names to use
	array		.req	r0
	length		.req	r1
	i			.req	r2
	j			.req	r3	
	currElem	.req	r4
	nextElem	.req	r5
	currPtr		.req	r6
	nextPtr		.req	r7
	sentinel	.req	r8
	
aBubbleSort:
	
	stmdb sp!, {r4-r8,r10,r11,lr} 		@; Push registers on stack

	sub i, length, #1					@; i = length - 1
	
iloop: @; /** for (i = 0; i < length; i++) **/
	
	mov j, #0							@; j = 0
	
	jloop: @; /** for (j = 0; j < length - i - 1; j++) **/
		
		/** Get a[j] **/
		add currPtr, array, j, LSL #2	@; currPtr = &a[j]
		ldr currElem, [currPtr]			@; currElem = a[j]
		
		/** Get a[j+1] **/
		add j, j, #1					@; j++
		add nextPtr, array, j, LSL #2	@; nextPtr = &a[j+1]
		ldr nextElem, [nextPtr]			@; nextElem = a[j+1]			
		
		if: @; /** If (a[j+1]) < a[j]) **/
		
			cmp nextElem, currElem
			bgt end_if
			
			str currElem, [nextPtr]		@; a[j+1] = a[j]
			str nextElem, [currPtr]		@; a[j] = a[j+1]
		
		end_if:
		
			cmp j, i					@; If j < i
			blt jloop					@; Branch to jloop
										@; Else go to end_jloop
	end_jloop:
			
		sub i, i, #1					@; i--
		cmp i, #2						@; If i >= 2
		bge iloop						@; Then branch to iloop
		
end:
	ldmia sp!, {r4-r8,r10,r11,lr} 		@; Pop registers off stack
	bx 	  lr
	.end
