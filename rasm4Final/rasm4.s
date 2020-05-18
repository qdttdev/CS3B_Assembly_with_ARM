/************************************************************************
 * Name:	Caroline Ta (Member 1) & Isaac Estrada (Member 2)
 * Program:	rasm4.s
 * Class:	CS3B
 * Lab:		Rasm4 
 * Date:	04-22-2020
 * Purpose:	This program creates a Menu driver program that serves as a 
 *			text editor and save the resulting text to a file			
 ***********************************************************************/
.data

		@; VARIABLES
		byteCount: 		 	.word 	0
		byte_string:	 	.skip 	12
		nodeCount: 		 	.word 	0
		node_string:	 	.skip 	12
		head_ptr:		 	.word 	0
		char_nL:		 	.byte 	10
		tail_ptr:		 	.word 	0
		index:		      	.word 	0
		ptrsubStr:	      	.word 	0
		ptrStr:		      	.word 	0

		@; CLASS HEADER	
		szName:				.asciz	"\tName:       Caroline Ta (Member 1) & Isaac Estrada (Member 2) "
		szProg:				.asciz	"\tAssignment: Rasm4"
		szClass:			.asciz	"\tClass:      CS3B"
		szDate:				.asciz	"\tDate:       04-22-2020"
		cCr:				.byte 	10

		outFile: 		  	.asciz  "output.txt"
		rasmTitle:		  	.asciz  "\n\tRASM4 TEXT EDITOR\n"
		memoryComp:	      	.asciz  "\tData Structure Memory Consumption: "
		bytes:			  	.asciz  " bytes\n"
		numNodesP:		  	.asciz  "\tNumber of Nodes: "
		enterStringP:	  	.asciz  "Enter string: "
		enterIndexPrompt: 	.asciz  "Enter line number: "
		InvalidInP:		  	.asciz  "Invalid index, not in range\n"
		InvalidInP2:	  	.asciz  "Invalid input\n"
		emptyList:		  	.asciz  "List is empty!\n"
		endl:			  	.asciz  "\n"
		idle_prompt:      	.asciz  "\nPRESS ENTER TO CONTINUE"
		fileWritePrompt:  	.asciz  "FILE IS READ from \"input.txt\""
		fileSavePrompt:   	.asciz  "FILE IS SAVED to \"output.txt\""
		fileOut:          	.asciz  "output.txt"
		removeNodePrompt: 	.asciz  "IS REMOVED\n"
		inputBuffer:	  	.skip   SIZE
		char_lP:          	.byte 	40
		char_rP:          	.byte 	41
		char_wS:          	.byte 	32
		
.text
.global _start
.equ	SIZE, 1024 
.extern malloc
.extern free

_start:

		@; Generate new screen with Menu options
		mov r0, #100				@; r0 = 100
		ldr r1, =endl				@; Load into r1 the address of endl
	
cls_loop:
		bl 		putstring			@; Call putch macro to output
		sub 	r0, #1				@; r0 = r0 - 1
		cmp 	r0, #0				@; Compare if r0 == 0
		bgt 	cls_loop			@; Branch to Menu_Screen if r0 > 0

	/************************
	 ** PRINT CLASS HEADER **
	 ************************/
		ldr		r1, =cCr			@; Load into r0 the address of crCr
		bl		putch				@; Call putch macro to output newline		
		ldr 	r1, =szName			@; Load into r0 the address of szName
		bl 		putstring			@; Call putstring macro to output
		ldr		r1, =cCr			@; Load into r0 the address of crCr
		bl		putch				@; Call putch macro to output newline		
		ldr 	r1, =szProg			@; Load into r0 the address of szProg
		bl 		putstring			@; Call putstring macro to output
		ldr		r1, =cCr			@; Load into r0 the address of crCr
		bl		putch				@; Call putch macro to output newline		
		ldr 	r1, =szClass		@; Load into r0 the address of szClass
		bl 		putstring			@; Call putstring macro to output
		ldr		r1, =cCr			@; Load into r0 the address of crCr
		bl		putch				@; Call putch macro to output newline		
		ldr 	r1, =szDate			@; Load into r0 the address of szDate
		bl 		putstring			@; Call putstring macro to output
		ldr		r1, =cCr			@; Load into r0 the address of crCr
		bl		putch				@; Call putch macro to output newline
		ldr		r1, =cCr			@; Load into r0 the address of crCr
		bl		putch				@; Call putch macro to output

	/************************
	 ** PRINT RASM HEADER  **
	 ************************/
	@; Output rasm title
		mov r0, #1					@; r0 = 1
		ldr r1, =rasmTitle			@; Load into r0 the address of Border 
		bl putstring				@; Call putstring macro to output
		ldr r1, =memoryComp			@; Load into r0 the address of memoryComp
		bl putstring				@; Call putstring macro to output
		
	@; Output byte count
		ldr r0, =byteCount			@; Output byte count on the screen
		ldr r0, [r0]				@; Load the value of r0
		ldr r1, =byte_string		@; Load into r1 the address of byte_string
		bl intasc32					@; Call intasc32 to convert to ascii
		bl putstring				@; Call putstring macro to output
		ldr r1, =bytes				@; Output "bytes"
		bl putstring				@; Call putstring macro to output
			
	@; Output node count
		ldr r1, =numNodesP			@; Output "Number of Nodes: "
		bl putstring				@; Call putstring macro to output
		ldr r0, =nodeCount			@; Output number of nodes to the screen
		ldr r0, [r0]				@; Load the value of r0
		ldr r1, =node_string		@; Load into r0 the address of node_string
		bl intasc32					@; Call intasc32 to convert to ascii
		bl putstring				@; Call putstring macro to output
	
	/************************
	 ** PRINT MENU OPTIONS **
	 ************************/
	 
		ldr r1, =endl				@; Load into r0 the address of endl
		bl putstring				@; Call putstring macro to output
		bl menu						@; Output the menu to view selection
	
	/********************
	 ** PROCESS OPTION **
	 ********************/
	 
		cmp 	r0, #'1'			@; Compare if input == 1
		beq 	printListOption		@; Branch to printListOption
		cmp 	r0, #'a'			@; Compare if input == a
		beq 	addStringOption		@; Branch to addStringOption
		cmp 	r0, #'A'			@; Compare if input == A
		beq		addStringOption		@; Branch to addStringOption
		cmp 	r0, #'b'			@; Compare if input == b
		beq 	fileStringsOption	@; Branch to fileStringsOption
		cmp 	r0, #'B'			@; Compare if input == B
		beq 	fileStringsOption	@; Branch to fileStringsOption
		cmp		r0, #'3'			@; Compare if input == 3
		beq		removeStringOption	@; Branch to removeStringOption
		cmp		r0, #'4'			@; Compare if input == 4
		beq		editStringOption	@; Branch to editStringOption
		cmp		r0, #'5'			@; Compare if input == 5
		beq		searchStringOption	@; Branch to searchStringOption
		cmp		r0, #'6'			@; Compare if input == 6
		beq		saveFileOption		@; Branch to saveFileOption
		cmp		r0, #'7'			@; Compare if input == 7
		beq		endProgramOption	@; Branch to endProgramOption		
		b 		_start				@; Branch to _start

editStringOption:

	/********************
	 ** CHECK IF EMPTY **
	 ********************/
		ldr 	r1, = head_ptr		@; Load into r1 the address of head_ptr
		ldr 	r1, [r1]			@; Load the value of r1
		cmp 	r1, #0				@; Compare if r1 == 0
		beq 	listEmpty			@; Branch to listEmpty if r1 == 0

	@; Generate new screen with Menu options
		mov 	r0, #100			@; r0 = 100
		ldr 	r1, =endl			@; Load into r0 the address of endl
		
	cls10_loop:
		bl 		putstring			@; Call putstring macro to output
		sub 	r0, #1				@; r0 = r0 - 1
		cmp 	r0, #0				@; Compare if r0 == 0
		bgt cls10_loop				@; Branch to Menu_Screen_10 if r0 > 0

	@; Prompt user for line number to edit
		ldr 	r1, =enterIndexPrompt	@; Load into r0 the address of enterIndexPrompt
		bl 		putstring			@; Call putstring macro to output
		ldr 	r1, =inputBuffer	@; Load into r1 the address of inputBuffer
		mov 	r2, #SIZE			@; Load SIZE into r2
		bl 		getstring			@; Branch to getstring
		ldr 	r1, =inputBuffer	@; Load into r1 the address of inputBuffer
		bl 		ascint32			@; Convert ascii to int
		sub 	r0, #1				@; r0 = r0 - 1
		ldr 	r1, =index			@; Load into r1 the address of index
		str 	r0, [r1]			@; Store value from r0 to r1
		cmp 	r0, #0				@; Compare if r0 == 0
		blt 	invalidRange		@; Branch to invalidRange if r0 < 0
		ldr 	r1, =nodeCount		@; Load into r1 the address of nodeCount
		ldr 	r1, [r1]			@; Load the value of r1
		cmp 	r0, r1				@; Compare r0 == r1
		bgt 	invalidRange		@; Branch to invalidRange if r0 > r1

	@; Get node index
		ldr 	r1, =head_ptr 		@; Load into r1 the address of head_ptr
		mov 	r2, r0  			@; Index of node: r2 = r0
		bl 		data_at 			@; Call data_at to get address of desired node data
		cmp 	r0, #0				@; Compare if r0 == 0
		beq 	invalidRange		@; If null was returned, then output that desired index is invalid

	@; Get String length
		mov 	r4, r0 				@; r4 = r0
		ldr 	r1, [r4] 			@; Load value at r4 into r1
		bl 		String_length		@; Branch to String_length
		mov 	r6, r0 				@; Move the string length of the old string into r6

	@; Prompt user for new string
		ldr		r1, =enterStringP	@; Load into r0 the address of enterStringP
		bl 		putstring			@; Call putstring macro to output
		ldr 	r1, =inputBuffer	@; Load into r1 the address of inputBuffer
		mov 	r2, #SIZE			@; r2 = SIZE
		bl 		getstring			@; Branch to getstring
		ldr 	r1, =inputBuffer	@; Load into r1 the address of inputBuffer
		bl 		String_copy			@; Branch to String_copy
		mov 	r1, r0				@; r1 = r0
		ldr 	r2, =char_nL		@; Load into r2 the address of char_nL
		bl 		String_concat		@; Branch to String_concat
		mov 	r5, r0				@; r5 = r0
		mov 	r0, r1				@; r0 = r1
		push 	{r0-r12}			@; Push registers r0-r12
		bl 		free				@; Free memory
		pop 	{r0-r12}			@; Pop registers r0-r12
	
	@; Modify byte count using String_length
		mov 	r0, r5				@; r0 = r5
		mov 	r2, r0 				@; String address is in r1
		mov 	r1, r0				@; r1 = r0
		bl 		String_length		@; Get string length of new string

		ldr 	r1, =byteCount		@; Load byteCount variable
		ldr 	r5, [r1]			@; Load byteCount value
		sub 	r5, r6 				@; r5 = r5 - r6
		add 	r5, r0				@; Sum the total byte count
		str 	r5, [r1]			@; Store the new byte count, which will increment bytes displayed on screendisplayed on screen

	@; Call edit_node
		ldr 	r1, =head_ptr		@; Load into r1 the address of head_ptr
		ldr 	r3, =index			@; Load into r3 the address of index
		ldr 	r3, [r3]			@; Load the value of r3
		bl 		edit_node			@; Branch to edit_node

		b 		_start				@; Branch to _start
	
	/*****************************************
	 ** ERROR PROMPT FOR EDIT STRING OPTION **
	 *****************************************/
	 
invalidRange:
		mov 	r0, #100			@; r0 = 100
		ldr 	r1, =endl			@; Load into r0 the address of endl
		
cls8_loop:
		bl 		putstring			@; Branch to putstring
		sub 	r0, #1				@; r0 = r0 - 1
		cmp 	r0, #0				@; Compare if r0 == 0
		bgt 	cls_loop			@; Branch to Menu_screen
		ldr 	r1, =InvalidInP 	@; Load into r0 the address of InvalidInp
		bl 		putstring			@; Output invalid range
		ldr 	r1, =idle_prompt	@; Load into r1 the address of idle_prompt
		bl 		putstring			@; Call putstring macro to output
		ldr 	r1, =inputBuffer	@; Load into r1 the address of inputBuffer
		bl 		getstring			@; Branch to getstring
		
		b 		_start				@; Branch to _start

invalidInput:
	@; Output menu
		mov 	r0, #100			@; r0 = 100
		ldr 	r1, =endl			@; Load into r0 the address of endl
		
cls9_loop:
		bl 		putstring			@; Call putstring macro to output
		sub 	r0, #1				@; r0 = r0 - 1
		cmp 	r0, #0				@; Compare if r0 == 0
		bgt 	cls_loop			@; Branch to Menu_screen if r0 > 0
		ldr 	r1, =InvalidInP2	@; Load into r0 the address of InvaidInP2
		bl 		putstring			@; Call putstring macro to output
		ldr 	r1, =idle_prompt	@; Load into r0 the address of idle_prompt
		bl 		putstring			@; Call putstring macro to output
		ldr 	r1, =inputBuffer	@; Load into r1 the address of inputBuffer
		bl 		getstring			@; Branch to getstring
		
		b 		_start				@; Branch to _start

	
printListOption:

	/*****************************************
	 ** CHECK IF LIST IS EMPTY BEFORE PRINT **
	 *****************************************/
		ldr 	r1, =head_ptr		@; Load into r1 the addr of head_ptr
		ldr 	r1, [r1]			@; Load the value of r1
		cmp 	r1, #0				@; Compare if r1 == 0
		beq 	listEmpty			@; Branch to listEmpty if r1 == 0
		ldr 	r1, =head_ptr		@; Load into r1 the addr of head_ptr
		bl 		print_list			@; Branch to print_list
		ldr 	r1, =idle_prompt	@; Load into r0 the addr of idle_prompt
		bl 		putstring			@; Call putstring macro to output
		ldr 	r1, =inputBuffer	@; Load into r1 the addr of inputBuffer
		bl 		getstring			@; Branch to getstring
		
		b 		_start				@; Branch to _start
	
listEmpty:
	@; Output Menu
		mov 	r0, #100			@; r0 = 100
		ldr 	r1, =endl			@; Load into r1 the addr of endl
		
cls4_loop:
		bl 		putstring			@; Call putstring macro to output
		sub 	r0, #1				@; r0 = r0 - 1
		cmp 	r0, #0				@; Compare if r0 == 0
		bgt 	cls4_loop			@; Branch to Menu_Screen_4

	@; Print empty list
		ldr 	r1, =emptyList		@; Load into r0 the addr of emptyList
		bl 		putstring			@; Call putstring macro to output
		ldr 	r1, =idle_prompt	@; Load into r0 the addr of idle_prompt
		bl 		putstring			@; Call putstring macro to output
		ldr 	r1, =inputBuffer	@; Load into r1 the addr of inputBuffer
		bl 		getstring			@; Branch to getstring
		
		b 		_start				@; Branch to _start

	/************************
	 ** ADD STRING OPTIONS **
	 ************************/

addStringOption:
	@; Prompt the user for new string input
		mov		R0, #1				@; Set output to stdout
		ldr 	r1, =enterStringP	@; Load into r1 the addr of enterStringP
		bl 		putstring			@; Call putstring macro to output
		ldr 	r1, =inputBuffer	@; Load into r1 the addr of inputBuffer
		mov 	r2, #SIZE			@; Load SIZE into r2
		bl 		getstring			@; Branch to getstring
		ldr 	r1, =inputBuffer	@; Load into r1 the addr of inputBuffer
		bl 		String_copy			@; Branch to String_copy
		mov 	r1, r0				@; r1 = r0
		ldr 	r2, =char_nL		@; Load into r2 the addr of char_nL
		bl 		String_concat		@; Branch link to string concat
		mov 	r5, r0				@; r5 = r0
		mov 	r0, r1				@; r0 = r1
		push 	{r0-r12}			@; Push registers r0-r12
		bl 		free				@; Free memory
		pop 	{r0-r12}			@; Pop registers r0-r12		
	
	@; Increment byte count
		mov 	r0, r5				@; r0 = r5
		mov 	r1, r0				@; r1 = r0
		bl 		String_length		@; Branch and link to String_length
		add 	r0, #9				@; Add 1 to string length for null byte
		ldr 	r1, =nodeCount		@; Load into r1 the address of nodeCount
		ldr 	r6, [r1]			@; Load the value in r1 into r6
		add 	r6, #1				@; r6 = r6 + 1
		str 	r6, [r1]			@; Store the value in r6 into r1
		ldr 	r1, =byteCount		@; Load byteCount variable
		ldr 	r3, [r1]			@; Load byteCount value
		add 	r3, r0				@; Sum the total byte count
		str 	r3, [r1]			@; Store the new byte count, which will increment 
									@; bytes displayed on screen

	@; Generate a new 8 byte link node
		bl 		build_node			@; Build new node with string
		mov 	r1, r0				@; r1 = r0
		mov 	r2, r5				@; Preverse new string
		bl 		fill_node			@; Stick data address into node

	@; Check to addHead or addTail
		mov 	r4, r1				@; r4 = r1
		ldr 	r1, =head_ptr		@; Load into r1 the addr of head_ptr
		ldr 	r1, [r1]			@; Load the value of r1
		cmp 	r1, #0				@; Compare r1 == 0
		bne 	addTail				@; Branch to addTail if r1 != 0
		
addHead:
		mov 	r1, r4				@; r1 = r4
		mov 	r2, #0				@; r2 = 0
		bl 		link_node 			@; Branch to link_node
		ldr 	r1, =head_ptr		@; Load into r1 the addr of head_ptr
		str 	r4, [r1]			@; Store value in r4 into r1
		
		b 		_start				@; Branch to _start
addTail:
		mov 	r1, r4				@; r1 = r4
		mov 	r2, #0				@; r2 = 0
		bl 		link_node			@; Branch to link_node
		ldr 	r1, =head_ptr		@; Load into r1 the addr of head_ptr
		mov 	r2, r4				@; r2 = r4
		bl 		link_tail			@; Branch to link_tail
		
		b 		_start				@; Branch to _start

fileStringsOption:
	@; Load input from file
		ldr 	r1, =head_ptr		@; Load into r1 the addr of head_ptr
		bl 		load_file			@; Branch to load_file
		mov 	r5, r0				@; r5 = r0
		mov 	r6, r2				@; r6 = r2
		ldr 	r4, =head_ptr		@; Load into r4 the addr of head_ptr
		str 	r1, [r4]			@; Store value in r1 into r4

	@; UpdatebyteCount
		ldr 	r1, =byteCount		@; Load byteCount variable
		ldr 	r0, [r1]			@; Load value into r0
		add 	r0, r5				@; Sum the total byte count
		str 	r0, [r1]			@; Store the new byte count, which will increment bytes displayed on screen
		ldr 	r1, =nodeCount		@; Load into r1 the addr of nodeCount
		ldr 	r0, [r1]			@; Load value into r0
		add 	r0, r6				@; r0 = r0 + r6
		str 	r0, [r1]			@; Store value from r0 to r1

		@; Output menu
		mov 	r0, #100			@; r0 = 100
		ldr 	r1, =endl			@; Load into r1 the addr of endl
		
cls2_loop:
		bl 		putstring			@; Call putstring macro to output
		sub 	r0, #1				@; r0 = r0 - 1
		cmp 	r0, #0				@; Compare if r0 == 0
		bgt 	cls2_loop			@; Branch to Menu_Screen_2 if r0 > 0
		ldr 	r1, =fileWritePrompt	@; Load into r0 the addr of fileWritePrompt
		bl 		putstring			@; Call putstring macro to output
		ldr 	r1, =idle_prompt	@; Load into r0 the addr of idle_prompt
		bl 		putstring			@; Call putstring macro to output
		ldr 	r1, =inputBuffer	@; Load into r1 the addr of inputBuffer
		bl 		getstring			@; Branch to getstring
		
		b 		_start				@; Branch to _start

	/**************************
	 ** SEARCH STRING OPTION **
	 **************************/
searchStringOption:
	@; Check if head is empty
		ldr 	r1, =head_ptr		@; Load into r1 the addr of head_ptr
		ldr 	r0, [r1]			@; Load value into r0
		cmp 	r0, #0				@; Compare r0 == 0
		beq 	listEmpty			@; Branch to listEmpty if r0 == 0

	@; Output menu
		mov 	r0, #100			@; r0 = 100
		ldr 	r1, =endl			@; Load into r1 the addr of endl
		
cls5_loop:
		bl 		putstring			@; Call putstring macro to output
		sub 	r0, #1				@; r0 = r0 - 1
		cmp 	r0, #0				@; Compare if r0 == 0
		bgt 	cls5_loop			@; Branch to Menu_Screen_5 if r0 > 0
		mov 	r0, #1				@; r0 = 1

	@; Prompt to search string and output string searched
		ldr 	r1, =enterStringP	@; Load into r1 the addr of enterStringP
		bl 		putstring			@; Call putstring macro to output
		ldr 	r1, =inputBuffer	@; Load into r1 the addr of inputBuffer
		mov 	r2, #SIZE			@; Load SIZE into r2
		bl 		getstring			@; Branch to getstring
		ldr 	r1, =inputBuffer	@; Load into r1 the addr of inputBuffer
		bl 		String_copy			@; Branch to String_copy
		ldr 	r1, =head_ptr		@; Load into r1 the addr of head_ptr
		mov 	r2, r0 				@; Make copy of desired string input and put in r3
		bl 		search_list			@; Branch to search_list
		ldr 	r1, =idle_prompt	@; Load into r1 the addr of idle_prompt
		bl 		putstring			@; Call putstring macro to output
		ldr 	r1, =inputBuffer	@; Load into r1 the addr of inputBuffer
		bl 		getstring			@; Branch to getstring
		
		b 		_start				@; Branch to _start 

	/**********************
	 ** SAVE FILE OPTION **
	 **********************/
saveFileOption:
	@; Open new output file to write
		ldr 	r0, =fileOut		@; Load into r0 the addr of fileOut
		mov 	r1, #0101			@; r1 = 0101
		ldr 	r2, =0666			@; Load into r2 addr of 0666
		mov 	r7, #5				@; r7 = 5
		svc 	0					@; Service call
		mov 	r2, r0				@; r2 = r0
		ldr 	r1, =head_ptr		@; Load into r1 the addr of head_ptr
		bl 		write_list			@; Branch to write_list

	@; Output menu
		mov 	r0, #100			@; r0 = 100
		ldr 	r1, =endl			@; Load into r1 the addr of endl
		
cls3_loop:
		bl 		putstring			@; Call putstring macro to output
		sub 	r0, #1				@; r0 = r0 - 1
		cmp 	r0, #0				@; Compare if r0 == 0
		bgt 	cls3_loop			@; Branch to Menu_Screen_3 if r0 > 3
		ldr 	r1, =fileSavePrompt	@; Load into r0 the addr of fileSavePrompt
		bl 		putstring			@; Call putstring macro to output
		ldr 	r1, =idle_prompt	@; Load into r0 the addr of idle_prompt
		bl 		putstring			@; Call putstring macro to output
		ldr 	r1, =inputBuffer	@; Load into r1 the addr of inputBuffer
		bl 		getstring			@; Branch to getstring
		
		b 		_start				@; Branch to _start

	/**************************
	 ** DELETE STRING OPTION **
	 **************************/
removeStringOption:
	@; Check if head is empty
		ldr 	r1, =head_ptr		@; Load into r1 the addr of head_ptr
		ldr 	r0, [r1]			@; Load value into r0
		cmp 	r0, #0				@; Compare if r0 == 0
		beq 	listEmpty			@; Branch to listEmpty if r0 == 0

	@; Output menu
		mov 	r0, #100			@; r0 = 100
		ldr 	r1, =endl			@; Load into r1 the addr of endl
		
cls6_loop:
		bl 		putstring			@; Call putstring macro to output
		sub 	r0, #1				@; r0 = r0 - 1
		cmp 	r0, #0				@; Compare if r0 == 0
		bgt 	cls6_loop			@; Branch to Menu_Screen_6 if r0 > 0
		mov 	r0, #1				@; r0 = 1
		
	@; Prompt for search string
		ldr 	r1, =enterIndexPrompt	@; Load intor r0 the addr of enterIndexPrompt
		bl 		putstring			@; Call putstring macro to output
		ldr 	r1, =inputBuffer	@; Load into r1 the addr of inputBuffer
		mov 	r2, #SIZE			@; Load SIZE into r2
		bl 		getstring			@; Branch to getstring
		ldr 	r1, =inputBuffer	@; Load into r1 the addr of inputBuffer
		bl 		ascint32			@; Convert ascii to int
		sub 	r0, #1				@; r0 = r0 - 1
		ldr 	r1, =index			@; Load into r1 the addr of index	
		str 	r0, [r1]			@; Store value from r0 into r1
		cmp 	r0, #0				@; Compare if r0 == 0 
		blt 	invalidRange		@; Branch to invalidRange if r0 < 0
		ldr 	r1, =nodeCount		@; Load into r1 the addr of nodeCount
		ldr 	r1, [r1]			@; Load the value of r1
		cmp 	r0, r1				@; Compare r0 == r1
		bgt 	invalidRange		@; Branch to invalidRange if r0 > r1

	@; Get indexed node
		ldr 	r1, =head_ptr 		@; Load head_ptr into r1
		mov 	r2, r0  			@; Index of node
		bl 		data_at 			@; Call data_at to get address of desired node data
		cmp 	r0, #0				@; If null was returned, then output that desired index is invalid
		beq 	invalidRange

	@; Find string length
		mov 	r4, r0 				@; Mov desired node address to r4
		ldr 	r1, [r4] 			@; Load string from desired node
		bl 		String_length		@; Branch to String_length
		mov 	r6, r0 				@; Move the string length of the old string into r6
		ldr 	r1, =nodeCount		@; Load into r1 the addr of nodeCount
		ldr 	r0, [r1]			@; Load the value into r0
		sub 	r0, #1				@; r0 = r0 - 1
		str 	r0, [r1]			@; Store the value from r0 into r1
		ldr 	r1, =byteCount		@; Load into r1 the addr of byteCount
		ldr 	r0, [r1]			@; Load value into r0
		sub 	r0, #9				@; r0 = r0 - 9
		sub 	r0, r6				@; r0 = r0 - r6
		str 	r0, [r1]			@; Store value from r0 to r1

	@; Remove node
		ldr 	r1, =char_lP		@; Load into r1 the addr of char_lP
		bl 		putch				@; Branch to putch
		ldr 	r1, =index			@; Load into r1 the addr of index
		ldr 	r0, [r1]			@; Load the value into r0
		add 	r0, #1				@; r0 = r0 + 1
		ldr 	r1, =byte_string	@; Load into r1 the addr of byte_string
		bl 		intasc32			@; Convert int to ascii
		bl 		putstring			@; Call putstring macro to output
		ldr 	r1, =char_rP		@; Load into r1 the addr of char_rP
		bl 		putch				@; Branch to putch
		ldr 	r1, =char_wS		@; Load into r1 the addr of char_wS
		bl 		putch				@; Branch to putch
		ldr 	r1, [r4]			@; Load the value from r4 into r1
		bl 		putstring			@; Branch to putch
		ldr 	r1, =removeNodePrompt	@; Load into r1 the addr of removeNodePrompt
		bl 		putstring			@; Call putstring macro to output
		ldr 	r1, =index			@; Load into r1 the addr of index
		ldr 	r2, [r1]			@; Load value into r2
		ldr 	r1, =head_ptr		@; Load into r1 the addr of head_ptr
		bl 		remove_node			@; Branch to remove_node
		ldr 	r1, =idle_prompt	@; Load into r1 the addr of idle_prompt
		bl 		putstring			@; Call putstring macro to output
		ldr 	r1, =inputBuffer	@; Load into r1 the addr of inputBuffer
		bl 		getstring			@; Branch to getstring
		
		b 		_start				@; Branch to _start

endProgramOption:
		ldr 	r1, =head_ptr		@; Load into r1 the address of head_ptr
		bl 		clear_list			@; Branch to clear_list
		mov		r0, #0				@; Exit Status code set to 0 indicates "normal completion"
		mov 	r7, #1 				@; Service command code (1) will terminate this program
		svc 	0      				@; Issue Linux command to terminate program
		.end
