/****************************************************************************
 * Assembly Insertion Sort
 * --------------------------------------------------------------------------
 * R0:	Pointer to the first element of the array
 * R1:	Length of the array
 ***************************************************************************/

.global aInsertionSort

@; Creates an alias for registers with corresponding names to use
	array		.req	r0
	length		.req	r1
	i			.req	r2
	j			.req	r3
	next		.req	r8
	current		.req	r9
	temp		.req	r10
	
aInsertionSort:	

	stmdb sp!, {r4-r8,r10,r11,lr} 			@; Push registers on stack
	
	mov i, #1 								@; i = 1
	
	@; /** for(int i = 1; i < length; ++i) **/
	iloop:
	
		cmp i, length 						@; If i >= length (reach end of array)
		bge end								@; Then branch to end
		
		add temp, array, i, LSL #2			@; [temp] = array + (i * 4)
		ldr temp, [temp] 					@; temp = array[i]
		
		sub j, i, #1 						@; j = i - 1
		
		
		jloop: @; /** while(j >= 0 && a[j] > temp) **/ (Shift right)
		
			cmp j, #0 						@; If j < 0 (reach start of array)
			blt jloopend					@; Then branch to jloopend
			
			add current, array, j, LSL #2	@; [current] = array + (j * 4)
			ldr current, [current] 			@; current = array[j]
			
			cmp temp, current 				@; If temp >= current
			bge jloopend					@; Then branch to jloopend
			
			@; Shift to array[j+1]
			add next, array, j, LSL #2		@; next = array + (j * 4)
			add next, next, #4 				@; next = next + 4
			str current, [next] 			@; array[j+1] = current 
			
			sub j, j, #1 					@; j--
			
			b jloop							@; Branch to jloop
		
		/** Store into freed spot **/
		jloopend:	
			@; Shift to array[j+1]
			add j, j, #1					@; j = j + 1	
			add next, array, j, LSL #2		@; next = array + (j * 4)
			str temp, [next] 				@; array[j+1] = temp
			
			add i, i, #1 					@; i++
				
			b iloop							@; Branch to iloop

end:
	ldmia sp!, {r4-r8,r10,r11,lr} 			@; Pop registers off stack
	bx lr
	.end
