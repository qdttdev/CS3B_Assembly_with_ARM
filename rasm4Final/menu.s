/************************************************************************
 * Name:	Caroline Ta (Member 1) & Isaac Estrada (Member 2)
 * Program:	menu.s
 * Class:	CS3B
 * Lab:		Rasm4 
 * Date:	04-22-2020			
 ***********************************************************************/
	
	.global menu
	.global load_file
	.equ	SIZE, 1024 
	.data

	option1:		.asciz	"\n<1> View all strings\n"
	option2:		.asciz	"\n<2> Add string\n"
	option2a:		.asciz	"\n\t<a> from Keyboard"
	option2b:		.asciz 	"\n\t<b> from File. Static file named input.txt\n"
	option3:		.asciz	"\n<3> Delete string. Given an index #, delete the entire string and de-allocate memory (including the node).\n"
	option4:		.asciz 	"\n<4> Edit string. Given an index #, replace old string w/ new string. Allocate/De-allocate as needed.\n"
	option5: 		.asciz 	"\n<5> String search. Regardless of case, return all strings that match the substring given.\n"
	option6:		.asciz 	"\n<6> Save File (output.txt)\n"
	option7:		.asciz  "\n<7> Quit\n"
	enterPrompt: 	.asciz 	"\nEnter selection: "
	invalidMsg:		.asciz	"ERROR: Invalid Input!\n"
	input_buffer:	.skip	1025

	filename: 		.asciz 	"input.txt"
	file_handle: 	.word 	0
	head_ptr: 		.word 	0
	tail_ptr: 		.word 	0
	remainder_ptr: 	.word 	0
	byte_count: 	.word 	0
	node_count: 	.word 	0
	char_nL: 		.byte 	10
	stringEnd: 		.asciz 	"\n"
				.text

menu:
	push	{R4-R8, R10, R11, LR}		@; Push AAPCS Required registers
 
 	mov	R0,#1			
	
	ldr		r1,=option1			@; Displaying the menu options 1
	bl		putstring			@; branch to putstring
	ldr		r1,=option2			@; Displaying the menu options 2
	bl		putstring			@; branch to putstring
	ldr		r1,=option3			@; Displaying the menu options 3
	bl		putstring			@; branch to putstring	
	ldr		r1,=option4			@; Displaying the menu options 4
	bl		putstring			@; branch to putstring
	ldr		r1,=option5			@; Displaying the menu options 5
	bl		putstring			@; branch to putstring
	ldr		r1,=option6			@; Displaying the menu options 6
	bl		putstring			@; branch to putstring
	ldr		r1,=option7			@; Displaying the menu options 7
	bl		putstring			@; branch to putstring
	ldr		r1,=enterPrompt		@; Displaying enter message
	bl		putstring			@; branch to putstring
	

	ldr	R1,=input_buffer	@; Load input buffer into R1
	mov	R2,#SIZE			@; Load input buffer size into R2
	bl	getstring			@; Getstring input
	bl String_length		@; branch to String_length
	cmp	R0,#2				@; Check if user input size is valid
	bgt	invalidInput		@; If user input is invalidInput, branch to invalidInput
	ldr	R1, =input_buffer	@; Load input buffer into R1
	ldrb R1,[R1]			@; Load first byte of user input
	cmp	R1,#'1'				@; If input is 0 or negative, branch to invalidInput input
	blt	invalidInput		@; branch to invalidInput
	cmp	R1,#'7'				@; If input is greater than 7, branch to invalidInput
	bgt	invalidInput		@; branch to invalidInput
	cmp	R1,#'2'				@; Check if user entered 2 for addingString
	bne	endMenu				@; If not equal to 2 branch to endMenu

	mov	R0,#1				@; If user inputs a 2, there is options for adding a string
	ldr	r1,=option2a		@; either add string  manually or read from file
	bl	putstring			@; branch to putstring
	ldr	r1,=option2b		@; load adress of option2b
	bl	putstring			@; branch to putstring

	@; Check to make sure this subselection is given a valid input
	
	ldr	R1,=input_buffer	@; Load input buffer into R1
	mov	R2,#SIZE			@; Load input buffer size into R2
	bl	getstring			@; Getstring input
	bl String_length
	cmp	R0,#2				@; Check if user input size is valid
	bgt	invalidInput		@; If user input is not valid branch to invalidInput
	ldr	R1,=input_buffer	@; Load input buffer into R1
	ldrb R1,[R1]			@; Load first byte of user input
	cmp	R1,#'a'				@; Check if user input 'a'
	beq	endMenu				@; If input is valid branch to endMenu
	cmp	R1,#'A'				@; Check if user input 'A'
	beq	endMenu				@; If input is valid branch to endMenu
	cmp	R1,#'b'				@; Check if user input 'b'
	beq	endMenu				@; If input is valid branch to endMenu
	cmp	R1,#'B'				@; Check if user input 'B'
	beq	endMenu				@; If input is valid branch to endMenu
	
invalidInput:	
	mov	R0,#1				@; Set output to stdout
	ldr	R1, =invalidMsg		@; Load invalid input message into R1
	bl	putstring			@; Output invalid input message
	pop {r4-r8,r10,r11,lr}	@; Restore AAPCS Required registers
	b	menu				@; Branch to menu

endMenu:
	mov	R0,R1					@; Move user input into R0
	pop	{R4-R8, R10, R11, LR}	@; Restore AAPCS Required registers
	bx	LR						@; Return to calling program

@@--- READ FROM FILE ---@@

load_file:
		push {r4-r8,r10,r11,lr} @; Push AAPCS Required registers
		ldr r0, =filename		@; load adress of filename
		mov r1, #00				@; load null into r1
		ldr r2, =0666			@; load 0666 into r2
		mov r7, #5				@; load calue of 5 into r7
		svc 0					@; Doing the thing
		cmp r0, #0    			@; branch to done if open fails
	    beq done				@; branch to done
		ldr r1, =file_handle	@; load adress of file_handle
		str r0, [r1]  			@; preserve the file handle
		mov r11, #1  			@; set r11 to 1, for control flag of buffer loop
		mov r10, #0				@; save value of 0 into r10
		mov r9, #0				@; save value of 0 into r10
buffer_loop:
		ldr r0, =file_handle	@; load adress of file_handle
		ldr r0, [r0]			@; load the value of r0 into r0
		cmp r11, #0				@; check if r11 = 0
		beq done				@; branch to done if r11 = 0
		ldr r1, =input_buffer	@; load adress of file_handle
		mov r2, #SIZE			@; save value of SIZE into r2
		mov r7, #3				@; save value of 3 into r7
		svc 0					@; do the thing

		cmp r0, #SIZE  			@; if bytes read is less than buffer size, file is done
		movlt r11, #0			@; save value of 0 into r11
		ldr r1, =byte_count		@; load adress of byte_count
		str r0, [r1]			@; store the value of r1 into r0
		mov r3, #SIZE			@; save the value of SIZE into r3
		sub r3, r0				@; subtract r0 from r3
		add r0, r3				@; add r3 to r0
		ldr r1, =input_buffer	@; load adress of input_buffer
		mov r2, #0				@; load the value of 0 into r2
		add r1, r0				@; add r1 to r0
		strb r2, [r1]     		@; add null terminator to end of buffer
		mov r7, #0				@; load the value of 0 into r7
inner_loop:
		ldr r1, =byte_count		@; load adress of byte_count
		ldr r1, [r1]			@; load the value of r1 into r1
		cmp r7, r1				@; check if r7 = r1
		bge inner_done			@; branch to inner_done
		ldr r1, =input_buffer	@; load adress of input_buffer
		add r1, r7				@; add r1 to r7
		ldr r2, =char_nL		@; load adress of char_nL
		ldrb r2, [r2]			@; load the value of r2 into r1
		bl String_indexOf_1		@; branch to String_indexOf_1
		cmp r0, #-1				@; check if r0 = -1
		beq inner_done			@; branch to inner_done
		mov r3, r0				@; save r0 iinto r3
		add r3, r7          	@; set end index to currentIndex + firstIndexOf result
		ldr r1, =input_buffer	@; load adress of byte_count
		mov r2, r7				@; save r7 into r2
		mov r7, r3       		@; save r3 into r7
		add r7, #1          	@; set current index to end of current string + 1
		ldr r5, =byte_count		@; load adress of byte_count
		ldr r5, [r5]			@; load the value of r5 into r5
		cmp r3, r5				@; check it r3 = r5
		movge r3, r5			@; move r5 into r3 if its greater
		subge r3, #1			@; sub 1 from r3 if its greater
		bl String_substring_1	@; branch to String_substring_1
		ldr r1, =remainder_ptr	@; load the adress of remainder_ptr
		ldr r1, [r1]			@; load the value of r1 into r1
		cmp r1, #0				@; check if 0 = r1
		blne remainder_include  @; branch to remainder_include
		mov r8, r0          	@; preserve our new string
		mov r1, r0				@; move r0 into r1
		bl String_length		@; branch to String_length
		add r10, r0				@; add r0 to r10
		add r10, #9      	    @; update our byte count (stringLength + 1)
		ldr r9, =node_count		@; load adress of node_count
		ldr r12, [r9]			@; load value of r9 into r12
		add r12, #1				@; add 1 to r12
		str r12, [r9]			@; store r12 into adress held by r9
		bl build_node			@; branch to build_node
		mov r2, r8				@; move r8 into r2
		mov r1, r0				@; move r0 into r1
		bl fill_node			@; branch to fill_node
		mov r2, r1				@; move r0 into r1
		ldr r1, =head_ptr		@; load adress of head_ptr
		ldr r1, [r1]			@; load value of r1 into r1
		cmp r1, #0       	    @; check if head is empty
		beq empty_head			@; branch to empty_head
		mov r1, r2				@; move r0 into r1
		mov r2, #0				@; move r0 into r1
		bl link_node			@; branch to link_node
		mov r2, r1				@; move r0 into r1
		ldr r1, =tail_ptr		@; load adress of tail_ptr
		@ldr r1, =head_ptr		@; load adress of head_ptr
		bl link_tail			@; branch to link_node
		str r2, [r1]			@; load value of r1 into r2
		b inner_loop			@; branch to inner_loop

empty_head:
		mov r1, r2				@; move r0 into r1
		mov r2, #0				@; move r0 into r1
		bl link_node			@; branch to link_node
		mov r2, r1				@; move r0 into r1
		ldr r1, =head_ptr		@; load adress of head_ptr
		str r2, [r1]			@; load value of r1 into r2
		ldr r1, =tail_ptr		@; load adress of tail_ptr
		str r2, [r1]			@; load value of r2 into r1
		b inner_loop			@; branch to inner_loop

remainder_include:
		push {lr}				@; Push AAPCS Required registers
		ldr r1, =remainder_ptr	@; load adress of remainder_ptr
		ldr r1, [r1]			@; load value of r9 into r12
		mov r2, r0				@; move r0 into r1
		bl String_concat		@; branch to link_node
		mov r5, r0				@; move r0 into r1
		mov r0, r2				@; move r0 into r1
		push {r0-r12}			@; Push AAPCS Required registers
		bl free					@; branch to free
		pop {r0-r12}			@; Restore AAPCS Required registers
		mov r0, r1				@; move r0 into r1
		push {r0-r12}			@; Push AAPCS Required registers
		bl free					@; branch to free
		pop {r0-r12}			@; Restore AAPCS Required registers
		mov r0, r5				@; move r0 into r1
		mov r2, #0				@; move r0 into r1
		ldr r3, =remainder_ptr	@; load adress of remainder_ptr
		str r2, [r3]			@; load value of r3 into r2
		pop {lr}				@; Restore AAPCS Required registers
		bx lr					

inner_done:
		cmp r11, #0				@; check if r11 = 0
		beq buffer_loop			@; branch to buffer_loop
		ldr r1, =input_buffer	@; load adress of input_buffer
		mov r2, r7				@; move r0 into r1
		ldr r3, =byte_count		@; load adress of byte_count
		ldr r3, [r3]			@; load value of r3 into r3
		sub r3, #1				@; sub 1 from r3
		bl String_substring_1	@; branch if string_dubstring_1
		ldr r1, =remainder_ptr	@; load adress of remainder_ptr
		str r0, [r1]			@; load value of r1 into r0
		b buffer_loop			@; branch to buffer_loop

done:
		ldr r0, =file_handle	@; load adress of file_handle
		ldr r0, [r0]			@; load value of r0 into r0
		mov r7, #6				@; move r0 into r1
		svc 0					@; do the thing 
		mov r0, r10				@; move r0 into r1
		ldr r2, =node_count		@; load adress of node_count
		ldr r2, [r2]			@; load value of r2 into r2
		ldr r1, =head_ptr		@; load adress of head_ptr
		ldr r1, [r1]			@; load value of r1 into r1
		pop {r4-r8,r10,r11,lr}	@; Restore AAPCS Required registers
		bx lr					
	.end
