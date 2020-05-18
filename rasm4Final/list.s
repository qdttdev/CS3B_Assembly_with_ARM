/************************************************************************
 * Name:	Caroline Ta (Member 1) & Isaac Estrada (Member 2)
 * Program:	menu.s
 * Class:	CS3B
 * Lab:		Rasm4 
 * Date:	04-22-2020			
 ***********************************************************************/

.global build_node
.global link_tail
.global fill_node
.global link_node
.global data_at
.global edit_node
.global print_list
.global search_list
.global write_list
.global remove_node
.global clear_list
.extern malloc
.extern free

.data
		char_lP: .byte 40 
		char_rP: .byte 41
		char_wS: .byte 32
		num_out: .skip 4
		
		
		.text
@;**********************************************************************
@; build_node:
@;----------------------------------------------------------------------
@; Generates a new 8 byte node 
@;
@;**********************************************************************

build_node:
		push {r4-r8,r10,r11,lr}	@; Preserve working register contents.
		mov r0, #8				@; Set r0 to 8
		bl malloc				@; allocate memory
		pop {r4-r8,r10,r11,lr}	@; Restore saved register contents
		bx lr					@; Return back to caller
		
@;**********************************************************************
@; link_tail:
@;----------------------------------------------------------------------
@; Adds a given node to the end of a given list 
@;		R1: Address of the head node
@;		R2: Address of the new node
@;**********************************************************************

link_tail:
		mov r8, r1				@; store r1 into r8
		push {r4-r8,r10,r11,lr}	@; Preserve working register contents.
		ldr r4, [r1]			@; load the value of r1 into r4	
tail_loop:
		cmp r4, #0				@; Check if r4 is equal to 0
		beq tail_end			@; branch to tail_end 
		mov r1, r4				@; Set r1 to r4
		add r4, #4				@; add 4 to r4
		ldr r4, [r4]			@; load the value of r4 into r4
		b tail_loop				@; branch to tail_loop
tail_end:
		bl link_node			@; branch to link_node
		pop {r4-r8,r10,r11,lr}	@; Restore saved register contents
		mov r1, r8				@; store r8 into r1
		bx lr					@; Return back to caller
		
@;**********************************************************************
@; fill_node:
@;----------------------------------------------------------------------
@; Inserts a data-address into a given node 
@;		R1: Address of the node
@;		R2: Address of the data
@;**********************************************************************

fill_node:
		push {r4-r8,r10,r11,lr} @; Preserve working register contents.
		ldr r4, [r1]			@; load the value of r1 into r4
		str r2, [r1]			@; load the value of r1 into r2
		pop {r4-r8,r10,r11,lr}	@; Restore saved register contents
		bx lr					@; Return back to caller
		
@;**********************************************************************
@; link_node:
@;----------------------------------------------------------------------
@; Links a node to a another given node
@;		R1: Address of the parent node
@;		R2: Address of the child data
@;**********************************************************************

link_node:
		push {r4-r8,r10,r11,lr}	@; Preserve working register contents.
		mov r4, r1				@; store r1 into r4		
		add r4, #4				@; add 4 to r4
		str r2, [r4]			@; store value of r4 into r2
		pop {r4-r8,r10,r11,lr}	@; Restore saved register contents
		bx lr					@; Return back to caller
		
@;**********************************************************************
@; data_at:
@;----------------------------------------------------------------------
@; Links a node to a another given node
@;		R1: Address of the head node
@;		R2: Index of node
@; Return:
@;		R0: Address of node's data
@;**********************************************************************

data_at:                                               
		push {r4-r8,r10,r11,lr} @; Preserve working register contents.
		ldr r4, [r1]			@; load the value of r1 into r4
at_loop:
		cmp r2, #0				@; Check if r2 is equal to 0
		beq at_done				@; branch to at_done
		add r4, #4				@; add 4 to r4
		ldr r4, [r4]			@; load the value of r4 into r4
		sub r2, #1				@; subtract 1 from r2
		b at_loop				@; branch to at_loop
at_done:
		mov r0, r4				@; store r4 into r0	
		pop {r4-r8,r10,r11,lr}	@; Restore saved register contents
		bx lr					@; Return back to caller
		
@;**********************************************************************
@; edit_node:
@;----------------------------------------------------------------------
@; Edit a node with the given index
@;		R1: Address of the head node
@;		R2: Address of the data
@;		R3: Index of node
@;**********************************************************************
edit_node:
		mov r8, r1				@; store r1 into r8
		push {r4-r8,r10,r11,lr}	@; Preserve working register contents.
		ldr r4, [r1]			@; load the value of r1 into r4
edit_loop:
		cmp r3, #0				@; Check if r3 is equal to 0
		beq edit_done			@; branch to edit_done
		add r4, #4				@; add 4 to r4
		ldr r4, [r4]			@; load the value of r4 into r4
		sub r3, #1				@; subtract 1 from r3
		b edit_loop				@; branch to edit_loop
edit_done:
		mov r1, r4				@; store r4 into r1
		bl fill_node			@; branch to edit_loop
		pop {r4-r8,r10,r11,lr}	@; Restore saved register contents
		mov r1, r8				@; store r8 into r1
		bx lr					@; Return back to caller

@;**********************************************************************
@; print_list:
@;----------------------------------------------------------------------
@; Prints the list to the console
@;		R1: Address of the head node
@;**********************************************************************
print_list:
		mov r8, r1				@; store r1 into r8
		push {r4-r8,r10,r11,lr} @; Preserve working register contents.
		ldr r4, [r1]			@; load the value of r1 into r4
		mov r7, #1				@; store 1 into r7 
print_loop:
		cmp r4, #0				@; Check if r3 is equal to 0
		beq print_end			@; branch to print_end
		ldr r1, =char_lP		@; load the adress of char_lP
		bl putch				@; branch to putch
		mov r0, r7				@; save r7 into r0
		ldr r1, =num_out		@; load the adress of num_out
		bl intasc32				@; branch to intasc32
		bl putstring			@; branch to putstring		
		add r7, #1				@; add 1 to r7
		ldr r1, =char_rP		@; load the adress of char_rP
		bl putch				@; branch to putch
		ldr r1, =char_wS		@; load the adress of char_wS
		bl putch				@; branch to putch
		ldr r1, [r4], #4		@; load the value of r1 into r4
		bl putstring			@; branch to putstring
		ldr r4, [r4]			@; load the value of r4 into r4
		b print_loop			@; branch to print_loop
print_end:
		pop {r4-r8,r10,r11,lr}	@; Restore saved register contents
		mov r1, r8				@; store r8 into r1
		bx lr					@; Return back to caller
		
@;**********************************************************************
@; search_list:
@;----------------------------------------------------------------------
@; Prints matching strings
@;**********************************************************************
search_list:
		mov r8, r1				@; store r1 into r8
		mov r10, r2				@; store r10 into r2
		push {r4-r8,r10,r11,lr}	@; Preserve working register contents.
		ldr r4, [r1]			@; load the value of r1 into r4
		mov r7, #1				@; store 1 into r7 
search_loop:
		cmp r4, #0				@; Check if r3 is equal to 0
		beq search_end			@; branch to print_end
		ldr r1, [r4]			@; load the value of r4 into r1
		mov r2, r10				@; save r10 into r2
		bl String_indexOf_3		@; branch to String_indexOf_3	
		cmp r0, #0				@; Check if r0 is equal to 0
		blt search_bypass_print	@; branch to search_bypass_print
		ldr r1, =char_lP		@; load the adress of char_lP
		bl putch				@; branch to putch	
		mov r0, r7				@; store r7 into r0
		ldr r1, =num_out		@; load the adress of num_out
		bl intasc32				@; branch to intasc32	
		bl putstring			@; branch to intasc32
		ldr r1, =char_rP		@; load the adress of char_rP
		bl putch				@; branch to intasc32
		ldr r1, =char_wS		@; load the adress of char_wS
		bl putch				@; branch to intasc32
		ldr r1, [r4]			@; load the value of r4 into r1
		bl putstring			@; branch to intasc32
search_bypass_print:
		add r7, #1				@; add 1 to r7
		add r4, #4				@; add 4 to r4
		ldr r4, [r4]			@; load the value of r4 into r4
		b search_loop			@; branch to search_loop
search_end:
		pop {r4-r8,r10,r11,lr}	@; Restore saved register contents
		mov r1, r8				@; store r8 into r1
		bx lr					@; Return back to caller

@;**********************************************************************
@; write_list:
@;----------------------------------------------------------------------
@; Write the list to a file
@;		R1: Address of head node
@;		R2: File handle for output
@;**********************************************************************
write_list:
		mov r8, r1				@; store r1 into r8
		push {r4-r8,r10,r11,lr}	@; Preserve working register contents.
		ldr r4, [r1]			@; load the value of r4 into r1
		mov r7, #4				@; store 4 into r7
		mov r3, r2				@; store r2 into r3
write_loop:
		cmp r4, #0				@; Check if r4 is equal to 0
		beq write_done			@; branch to write_done
		ldr r1, [r4], #4		@; load the value of r4 into r1
		bl String_length		@; branch to String_length
		mov r2, r0				@; store r0 into r2
		mov r0, r3				@; store r3 into r0
		svc 0					@; Do the thing
		ldr r4, [r4]			@; load the value of r4 into r4
		b write_loop			@; branch to write_loop
write_done:
		pop {r4-r8,r10,r11,lr}	@; Restore saved register contents
		mov r1, r8				@; store r8 into r1
		bx lr					@; Return back to caller
		
@;**********************************************************************
@; remove_node:
@;----------------------------------------------------------------------
@; Removes a node from a given list
@;		R1: Address of head node
@;		R2: Index of node to remove
@;**********************************************************************
remove_node:
		mov r8, r1				@; store r7 into r0
		push {r4-r8,r10,r11,lr}	@; Preserve working register contents.
		mov r3, #0				@; store r7 into r0
		ldr r4, [r1]			@; load the value of r4 into r1
remove_loop:
		cmp r2, #0				@; Check if r3 is equal to 0
		beq remove_consider		@; branch to remove_consider
		mov r3, r4				@; store r7 into r0
		add r4, #4				@; add 1 to r7
		ldr r4, [r4]			@; load the value of r4 into r4
		sub r2, #1				@; sub 1 form r2
		b remove_loop			@; branch to remove_loop
remove_consider:
		cmp r3, #0				@; Check if r3 is equal to 0
		beq remove_head			@; branch to remove_consider
		mov r5, r4				@; store r7 into r0
		add r5, #4				@; add 1 to r7
		ldr r5, [r5]			@; load the value of r4 into r1
		cmp r5, #0				@; Check if r3 is equal to 0	
		beq remove_tail			@; branch to intasc32
		b remove_middle			@; branch to intasc32
remove_head:
		ldr r0, [r4]			@; load the value of r4 into r1
		bl free					@; branch to remove_consider
		mov r0, r4				@; store r7 into r0
		add r4, #4				@; add 1 to r7
		ldr r5, [r4]			@; load the value of r4 into r1
		bl free					@; branch to free
		str r5, [r8]			@; store value of r4 into r2
		b remove_end			@; branch to intasc32
remove_tail:
		add r3, #4				@; add 1 to r7
		mov r0, #0				@; store r7 into r0
		str r0, [r3]			@; store value of r4 into r2
		ldr r0, [r4]			@; load the value of r4 into r1
		bl free					@; branch to intasc32
		mov r0, r4				@; store r7 into r0
		bl free					@; branch to free
		b remove_end			@; branch to remove_end
remove_middle:
		mov r1, r3				@; store r7 into r0
		mov r2, r5				@; store r7 into r0
		bl link_node			@; branch to intasc32
		ldr r0, [r4]			@; load the value of r4 into r1
		bl free					@; branch to free
		mov r0, r4				@; store r7 into r0
		bl free					@; branch to free
remove_end:
		pop {r4-r8,r10,r11,lr}	@; Restore saved register contents
		mov r1, r8				@; store r8 into r1
		bx lr					@; Return back to caller

@;**********************************************************************
@; clear_list:
@;----------------------------------------------------------------------
@; Removes a node from a given list
@;		R1: Address of head node
@;**********************************************************************
clear_list:
		mov r8, r1				@; store r7 into r0
		push {r4-r8,r10,r11,lr}	@; Preserve working register contents.
		ldr r1, [r1]			@; load the value of r4 into r1
clear_loop:
		cmp r1, #0				@; Check if r3 is equal to 0
		beq clear_end			@; branch to intasc32
		mov r5, r1				@; store r7 into r0
		ldr r0, [r1], #4		@; load the value of r4 into r1
		ldr r4, [r1]			@; load the value of r4 into r1
		push {r0-r12}			@; Preserve working register contents.
		bl free					@; branch to intasc32
		pop {r0-r12}			@; Restore saved register contents
		mov r0, r5				@; store r7 into r0
		push {r0-r12}			@; Preserve working register contents.
		bl free					@; branch to intasc32
		pop {r0-r12}			@; Restore saved register contents
		mov r1, r4				@; store r7 into r0
		b clear_loop			@; branch to intasc32
clear_end:
		pop {r4-r8,r10,r11,lr}	@; Restore saved register contents
		mov r1, r8				@; store r8 into r1
		mov r7, #0				@; store r0 into r7
		str r7, [r8]			@; store r8 into r7
		bx lr					@; Return back to caller
		.end
