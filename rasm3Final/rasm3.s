/************************************************************************
 * Name:	Caroline Ta (Member 1) & Isaac Estrada (Member 2)
 * Program:	rasm3.s
 * Class:	CS3B
 * Lab:		Rasm3 
 * Date:	04-08-2020
 * Purpose:	This program test functions of these following methods
 *
 * 		01. String_length 				
 *		02. String_equals 				
 *		03. String_equalsIgnoreCase		
 *		04. String_copy					
 *		05. String_substring_1			
 *		06. String_substring_2			
 *		07. String_charAt				
 *		08. String_startsWith_1			
 *		09. String_startsWith_2			
 *		10. String_endsWith			
 *
 *		11. String_indexOf_1
 *		12. String_indexOf_2
 *		13. String_indexOf_3
 *		14. String_lastIndexOf_1
 *		15. String_lastIndexOf_2
 *		16. String_lastIndexOf_3
 *		17. String_concat
 *		18. String_replace
 *		19. String_toLowerCase
 *		20. String_toUpperCase
 *			
 ***********************************************************************/

.data
		@; CLASS HEADER	
			szName:			.asciz	"\tName:       Caroline Ta (Member 1) & Isaac Estrada (Member 2) "
			szProg:			.asciz	"\tAssignment: Rasm3"
			szClass:		.asciz	"\tClass:      CS3B"
			szDate:			.asciz	"\tDate:       04-08-2020"

		@; INPUTS AND OUTPUTS PROMPTS
			cCr:			.byte 	10
			szSingleQuote:	.asciz "\'"
			szDoubleQuote:	.asciz "\""
			
			szTrue:			.asciz	"TRUE"
			szFalse:		.asciz	"FALSE"
			
			szStr1Pr:		.asciz	"s1 = "
			szStr2Pr:		.asciz	"s2 = "
			szStr3Pr:		.asciz	"s3 = "
			
			szLength1:		.asciz	"1.\ts1.String_Length() = "
			szLength2:		.asciz	"\ts2.String_Length() = "
			szLength3:		.asciz	"\ts3.String_Length() = "
			
			szStrEq13Pr:	.asciz	"2.\tString_equals(s1,s3) = "
			szStrEq11Pr:	.asciz	"3.\tString_equals(s1,s1) = "
			
			szStrEqIC13Pr:	.asciz	"4.\tString_equalsIgnoreCase(s1,s3) = "
			szStrEqIC11Pr:	.asciz	"5.\tString_equalsIgnoreCase(s1,s2) = "
			
			szStrCopyPr:	.asciz	"6.\ts4 = String_copy(s1)"
			szS1:			.asciz	"\ts1 = "
			szS4:			.asciz	"\ts4 = "
			
			szStrSubStr1:	.asciz	"7.\tString_substring_1(s3,4,13) = "
			
			szStrSubStr2:	.asciz	"8.\tString_substring_2(s3,7) = "
			
			szStrCharAt:	.asciz	"9.\tString_charAt(s2,4) = \'"
			
			szStrStartW1:	.asciz	"10.\tString_startsWith_1(s1,11,\"hat.\") = "
			
			szStrStartW2:	.asciz	"11.\tString_startsWith_2(s1,\"Cat\") = "
			
			szStrEndW:		.asciz	"12.\tString_endsWith(s1,\"in the hat.\") = "
			
			szStrIOf1:		.asciz	"13.\tString_indexOf_1(s2,\'g\') = "
			
			szStrIOf2:		.asciz	"14.\tString_indexOf_2(s2,\'g\',9) = "
			
			szStrIOf3:		.asciz	"15.\tString_indexOf_3(s2,\"eggs\") = "
			
			szStrLIOf1:		.asciz	"16.\tString_lastIndexOf_1(s2,\'g\') = "
			
			szStrLIOf2:		.asciz	"17.\tString_lastIndexOf_2(s2,\'g\',6) = "
			
			szStrLIOf3:		.asciz	"18.\tString_lastIndexOf_3(s2,\"egg\") = "
			
			szStrReplace:	.asciz	"19.\tString_replace(s1,\'a\',\'o\') = "
			
			szStrLowerC:	.asciz	"20.\tString_toLowerCase(s1) = "
			
			szStrUpperC:	.asciz	"21.\tString_toUpperCase(s1) = "
			
			szStrConcat:	.asciz	"22.\tString_concat(s1, \" \")\n\tString_concat(s1, s2) = "
						
		@; STRINGS VALUES OF NUM AND CALCULATIONS FOR INPUT/OUTPUT		
			szStr1:			.skip	512
			szStr2:			.skip	512
			szStr3:			.skip	512
			szStr1Size:		.skip	512	
			szStr2Size:		.skip	512	
			szStr3Size:		.skip	512	
			szStrCopy:		.skip	512
			szSubStr1:		.skip	512
			szSubStr2:		.skip	512	
			
			szIndex1: 		.skip 	20
			szIndex2: 		.skip 	20
			szIndex3: 		.skip 	20
			szLastIndex1: 	.skip 	20
			szLastIndex2: 	.skip 	20
			szLastIndex3: 	.skip 	20
			
			cChar:			.byte	0
			
		@; STRINGS FOR TEST CASES 10, 11, 12, 15, 18
			szTest:			.asciz  "TEST"
			szTest10:		.asciz	"hat."			
			szTest11:		.asciz	"Cat"
			szTest12:		.asciz	"in the hat."
			szTest15:		.asciz	"eggs"
			szTest22:		.asciz	" "		   

.text

.global _start 							@; Provide program starting address to Linker
						
_start:	

		/************************
		 ** PRINT CLASS HEADER **
		 ************************/
			ldr		r0, =cCr			@; Load into r0 the address of crCr
			bl		putch				@; Call putch macro to output newline
			
			ldr 	r0, =szName			@; Load into r0 the address of szName
			bl 		putstring			@; Call putstring macro to output
			ldr		r0, =cCr			@; Load into r0 the address of crCr
			bl		putch				@; Call putch macro to output newline
			
			ldr 	r0, =szProg			@; Load into r0 the address of szProg
			bl 		putstring			@; Call putstring macro to output
			ldr		r0, =cCr			@; Load into r0 the address of crCr
			bl		putch				@; Call putch macro to output newline
			
			ldr 	r0, =szClass		@; Load into r0 the address of szClass
			bl 		putstring			@; Call putstring macro to output
			ldr		r0, =cCr			@; Load into r0 the address of crCr
			bl		putch				@; Call putch macro to output newline
			
			ldr 	r0, =szDate			@; Load into r0 the address of szDate
			bl 		putstring			@; Call putstring macro to output
			ldr		r0, =cCr			@; Load into r0 the address of crCr
			bl		putch				@; Call putch macro to output newline
			ldr		r0, =cCr			@; Load into r0 the address of crCr
			bl		putch				@; Call putch macro to output				

@;**********************************************************************
@; 					TESTING CASES 01 - 12 (Member 1)
@;**********************************************************************
Member1:			 
			@;----------------------------------------------------------
			@; 1.	s1.String_Length() = 15
			@;		s2.String_Length() = 19
			@;		s3.String_Length() = 15
			@;----------------------------------------------------------

		/**********************************************
		 ** PROMPT USERS FOR STRINGS AND CALC LENGTH **
		 **********************************************/			
			/** Get s1 input **/
			ldr 	r0, =szStr1Pr		@; Load into r0 the address of szStr1Pr
			bl 		putstring			@; Call putstring macro to output: "Enter string:  "
			ldr 	r0, =szStr1			@; Load into r0 the address of szStr1			
			mov 	r1, #512			@; Dictates maximum bytes in buffer
			bl 		getstring			@; Call getstring macro to get string input	
			/** Check for String_Length of String1 **/
			bl		String_Length		@; Call String_Length
			mov		r3, r0				@; Store return value from r0 to r3
			/** Store into its string varible **/
			mov		r0, r3				@; r0 = r3
			ldr		r1, =szStr1Size		@; Load into r1 the address of szStr1Size
			bl		intasc32			@; Convert integer to ascii
			
			
			/** Get s2 input **/
			ldr 	r0, =szStr2Pr		@; Load into r0 the address of szStr2Pr
			bl 		putstring			@; Call putstring macro to output: "Enter string:  "
			ldr 	r0, =szStr2			@; Load into r0 the address of szStr2			
			mov 	r1, #512			@; Dictates maximum bytes in buffer
			bl 		getstring			@; Call getstring macro to get string input	
			/** Check for String_Length of String1 **/
			bl		String_Length		@; Call String_Length
			mov		r3, r0				@; Store return value from r0 to r3
			/** Store into its string varible **/
			mov		r0, r3				@; r0 = r3
			ldr		r1, =szStr2Size		@; Load into r1 the address of szStr2Size
			bl		intasc32			@; Convert integer to ascii
			
			
			/** Get s3 input **/
			ldr 	r0, =szStr3Pr		@; Load into r0 the address of szStr3Pr
			bl 		putstring			@; Call putstring macro to output: "Enter string:  "
			ldr 	r0, =szStr3			@; Load into r0 the address of szStr3			
			mov 	r1, #512			@; Dictates maximum bytes in buffer
			bl 		getstring			@; Call getstring macro to get string input	
			/** Check for String_Length of String1 **/
			bl		String_Length		@; Call String_Length
			mov		r3, r0				@; Store return value from r0 to r3
			/** Store into its string varible **/
			mov		r0, r3				@; r0 = r3
			ldr		r1, =szStr3Size		@; Load into r1 the address of szStr3Size
			bl		intasc32			@; Convert integer to ascii		
			
		/************************ 
		 ** OUTPUT CALCULATION **
		 ************************/	
			ldr		r0, =cCr			@; Load into r0 the address of crCr
			bl		putch				@; Call putch macro to output 			
			ldr		r0, =szLength1		@; Load into r0 the address of szLength1
			bl		putstring			@; Call putch macro to output  szLength1									
			ldr		r0, =szStr1Size		@; Load into r0 the address of szStr1Size
			bl		putstring			@; Call putch macro to output  szStr1Size	
			ldr		r0, =cCr			@; Load into r0 the address of crCr
			bl		putch				@; Call putch macro to output 
			
			ldr		r0, =szLength2		@; Load into r0 the address of szLength2
			bl		putstring			@; Call putch macro to output  szLength2									
			ldr		r0, =szStr2Size		@; Load into r0 the address of szStr2Size
			bl		putstring			@; Call putch macro to output  szStr2Size	
			ldr		r0, =cCr			@; Load into r0 the address of crCr
			bl		putch				@; Call putch macro to output 
			
			ldr		r0, =szLength3		@; Load into r0 the address of szLength3
			bl		putstring			@; Call putch macro to output  szLength3									
			ldr		r0, =szStr3Size		@; Load into r0 the address of szStr3Size
			bl		putstring			@; Call putch macro to output  szStr3Size	
			ldr		r0, =cCr			@; Load into r0 the address of crCr
			bl		putch				@; Call putch macro to output 
			
			ldr		r0, =cCr			@; Load into r0 the address of crCr
			bl		putch				@; Call putch macro to output				
			
			@;----------------------------------------------------------
			@; 2.	String_equals(s1,s3) = FALSE		
			@;----------------------------------------------------------
			
Func_2_1:	/** Test str1 and str3 **/		
						
			ldr		r0, =szStr1			@; Load into r0 the addr of szStr1
			ldr		r1, =szStr3			@; Load into r1 the addr of szStr3
			bl		String_equals		@; Call String_equals 
			mov		r2, r0				@; Makes copy of return in r0 into r2
			
			ldr		r0, =szStrEq13Pr	@; Load into r0 the address of szStrEq13Pr
			bl		putstring			@; Call putch macro to output  szStrEq13Pr	
			
			cmp		r2, #0				@; Compare r2 and 0
			beq		Func_2_1_F			@; Branch to Func_2_1_F if r2 == 0
			bne		Func_2_1_T			@; Branch to Func_2_1_T if r2 != 0
			
Func_2_1_F:
			ldr		r0, =szFalse		@; Load into r0 the address of szFalse
			bl		putstring			@; Call putch macro to output  szFalse
			ldr		r0, =cCr			@; Load into r0 the address of crCr
			bl		putch				@; Call putch macro to output
			ldr		r0, =cCr			@; Load into r0 the address of crCr
			bl		putch				@; Call putch macro to output
			b		Func_2_2			@; Branch to Func_2_2
Func_2_1_T:					
			ldr		r0, =szTrue			@; Load into r0 the address of szTrue
			bl		putstring			@; Call putch macro to output  szTrue	
			ldr		r0, =cCr			@; Load into r0 the address of crCr
			bl		putch				@; Call putch macro to output
			ldr		r0, =cCr			@; Load into r0 the address of crCr
			bl		putch				@; Call putch macro to output
			b		Func_2_2			@; Branch to Func_2_2
			
			@;----------------------------------------------------------
			@; 3.	String_equals(s1,s1) = TRUE		
			@;----------------------------------------------------------
			
Func_2_2:	/** Test str1 and str1 **/		
				
			ldr		r0, =szStr1			@; Load into r0 the addr of szStr1
			ldr		r1, =szStr1			@; Load into r1 the addr of szStr1
			bl		String_equals		@; Call String_equals
			mov		r2, r0				@; Makes copy of return in r0 into r2
			
			ldr		r0, =szStrEq11Pr	@; Load into r0 the address of szStrEq11Pr
			bl		putstring			@; Call putch macro to output  szStrEq11Pr	
			
			cmp		r2, #0				@; Compare r0 and 0
			beq		Func_2_2_F			@; Branch to Func_2_2_F if r2 == 0
			bne		Func_2_2_T			@; Branch to Func_2_2_T if r2 != 0
			
Func_2_2_F:
			ldr		r0, =szFalse		@; Load into r0 the address of szFalse
			bl		putstring			@; Call putch macro to output  szFalse
			ldr		r0, =cCr			@; Load into r0 the address of crCr
			bl		putch				@; Call putch macro to output
			ldr		r0, =cCr			@; Load into r0 the address of crCr
			bl		putch				@; Call putch macro to output
			b		Func_3_1			@; Branch to Func_3_1
Func_2_2_T:					
			ldr		r0, =szTrue			@; Load into r0 the address of szTrue
			bl		putstring			@; Call putch macro to output  szTrue	
			ldr		r0, =cCr			@; Load into r0 the address of crCr
			bl		putch				@; Call putch macro to output			
			ldr		r0, =cCr			@; Load into r0 the address of crCr
			bl		putch				@; Call putch macro to output			
			b		Func_3_1			@; Branch to Func_3_1
			@;----------------------------------------------------------
			@; 4.	String_equalsIgnoreCase(s1,s3) = TRUE		
			@;----------------------------------------------------------			

Func_3_1:	/** Test str1 and str3 **/		
						
			ldr		r0, =szStr1			@; Load into r0 the addr of szStr1
			ldr		r1, =szStr3			@; Load into r1 the addr of szStr3
			bl		String_equalsIgnoreCase		@; Call String_equalsIgnoreCase
			mov		r2, r0				@; Makes copy of return in r0 into r2
			
			ldr		r0, =szStrEqIC13Pr	@; Load into r0 the address of szStrEqIC13Pr
			bl		putstring			@; Call putch macro to output  szStrEqIC13Pr	
			
			cmp		r2, #0				@; Compare r0 and 0
			beq		Func_3_1_F			@; Branch to Func_3_1_F if r2 == 0
			bne		Func_3_1_T			@; Branch to Func_3_1_T if r2 != 0
			
Func_3_1_F:
			ldr		r0, =szFalse		@; Load into r0 the address of szFalse
			bl		putstring			@; Call putch macro to output  szFalse
			ldr		r0, =cCr			@; Load into r0 the address of crCr
			bl		putch				@; Call putch macro to output
			ldr		r0, =cCr			@; Load into r0 the address of crCr
			bl		putch				@; Call putch macro to output
			b		Func_3_2			@; Branch to Func_3_2
Func_3_1_T:					
			ldr		r0, =szTrue			@; Load into r0 the address of szTrue
			bl		putstring			@; Call putch macro to output  szTrue	
			ldr		r0, =cCr			@; Load into r0 the address of crCr
			bl		putch				@; Call putch macro to output
			ldr		r0, =cCr			@; Load into r0 the address of crCr
			bl		putch				@; Call putch macro to output
			b		Func_3_2			@; Branch to Func_3_2
			
			@;----------------------------------------------------------
			@; 5.	String_equalsIgnoreCase(s1,s2) = FALSE		
			@;----------------------------------------------------------
			
Func_3_2:	/** Test str1 and str2 **/		
				
			ldr		r0, =szStr1			@; Load into r0 the addr of szStr1
			ldr		r1, =szStr2			@; Load into r1 the addr of szStr2
			bl		String_equalsIgnoreCase		@; Call String_equalsIgnoreCase
			mov		r2, r0				@; Makes copy of return in r0 into r2
			
			ldr		r0, =szStrEqIC11Pr	@; Load into r0 the address of szStrEqIC11Pr
			bl		putstring			@; Call putch macro to output  szStrEqIC11Pr	
			
			cmp		r2, #0				@; Compare r0 and 0
			beq		Func_3_2_F			@; Branch to Func_3_2_F if r2 == 0
			bne		Func_3_2_T			@; Branch to Func_3_2_T if r2 != 0
			
Func_3_2_F:
			ldr		r0, =szFalse		@; Load into r0 the address of szFalse
			bl		putstring			@; Call putch macro to output  szFalse
			ldr		r0, =cCr			@; Load into r0 the address of crCr
			bl		putch				@; Call putch macro to output
			ldr		r0, =cCr			@; Load into r0 the address of crCr
			bl		putch				@; Call putch macro to output
			b		Func_4				@; Branch to Func_4
Func_3_2_T:					
			ldr		r0, =szTrue			@; Load into r0 the address of szTrue
			bl		putstring			@; Call putch macro to output  szTrue	
			ldr		r0, =cCr			@; Load into r0 the address of crCr
			bl		putch				@; Call putch macro to output
			ldr		r0, =cCr			@; Load into r0 the address of crCr
			bl		putch				@; Call putch macro to output			
			b		Func_4				@; Branch to Func_4
			
			@;----------------------------------------------------------
			@; 6.	s4 = String_copy(s1)
			@;		s1 = Cat in the hat.
			@;		s4 = Cat in the hat.	 		
			@;----------------------------------------------------------
Func_4:
			ldr		r0, =szStrCopyPr	@; Load into r0 the address of szStrCopyPr
			bl		putstring			@; Call putch macro to output  szStrCopyPr
			ldr		r0, =cCr			@; Load into r0 the address of crCr
			bl		putch				@; Call putch macro to output
			
			ldr		r0, =szS1			@; Load into r0 the address of szS1
			bl		putstring			@; Call putch macro to output  szS1
			ldr		r0, =szStr1			@; Load into r0 the address of szStr1
			bl		putstring			@; Call putch macro to output  szStr1
			ldr		r0, =cCr			@; Load into r0 the address of crCr
			bl		putch				@; Call putch macro to output
			
			ldr		r0, =szS4			@; Load into r0 the address of szS4
			bl		putstring			@; Call putch macro to output  szS4

			ldr		r0, =szStr1			@; Load into r0 the address of szStr1
						
			bl		String_copy			@; Call String_copy
			bl		putstring			@; Call putch macro to output  			
				
			ldr		r0, =cCr			@; Load into r0 the address of crCr
			bl		putch				@; Call putch macro to output
			ldr		r0, =cCr			@; Load into r0 the address of crCr
			bl		putch				@; Call putch macro to output
			
			@;----------------------------------------------------------
			@; 7.	String_substring_1(s3,4,13) = "in the hat"	 		
			@;----------------------------------------------------------
			ldr		r0, =szStrSubStr1	@; Load into r0 the address of szStrSubStr1
			bl		putstring			@; Call putch macro to output  szStrSubStr1			
			ldr		r0, =szDoubleQuote	@; Load into r0 the address of szDoubleQuote
			bl		putstring			@; Call putch macro to output  szDoubleQuote
Func_5:			
			ldr		r0, =szStr3			@; Load into r0 the address of szStr3
			mov		r1, #4				@; Begin index: r1 = 4
			mov		r2, #13				@; End   index: r2 = 13
			
			bl		String_substring_1 	@; Call String_substring_1
			bl		putstring			@; Call putch macro to output   
			
			ldr		r0, =szDoubleQuote	@; Load into r0 the address of szDoubleQuote
			bl		putstring			@; Call putch macro to output  szDoubleQuote
			ldr		r0, =cCr			@; Load into r0 the address of crCr
			bl		putch				@; Call putch macro to output
			ldr		r0, =cCr			@; Load into r0 the address of crCr
			bl		putch				@; Call putch macro to output			
			
			@;----------------------------------------------------------
			@; 8. 	String_substring_2(s3,7) = "the hat."		
			@;----------------------------------------------------------
			ldr		r0, =szStrSubStr2	@; Load into r0 the address of szStrSubStr2
			bl		putstring			@; Call putch macro to output  szStrSubStr2			
			ldr		r0, =szDoubleQuote	@; Load into r0 the address of szDoubleQuote
			bl		putstring			@; Call putch macro to output  szDoubleQuote			
						
Func_6:			
			ldr		r0, =szStr3			@; Load into r0 the address of szStr3
			mov		r1, #7				@; Begin index: r1 = 7
			
			bl		String_substring_2	@; Call String_substring_2
			bl		putstring			@; Call putch macro to output	
						
			ldr		r0, =szDoubleQuote	@; Load into r0 the address of szDoubleQuote
			bl		putstring			@; Call putch macro to output  szDoubleQuote	
			ldr		r0, =cCr			@; Load into r0 the address of crCr
			bl		putch				@; Call putch macro to output
			ldr		r0, =cCr			@; Load into r0 the address of crCr
			bl		putch				@; Call putch macro to output
			
			@;----------------------------------------------------------
			@; 9. 	String_charAt(s2,4) = 'n'	
			@;----------------------------------------------------------
			
Func_7:			
			ldr		r0, =szStr2			@; Load into r0 the address of szStr2
			mov		r1, #4				@; Position index: i = 4										
			
			bl		String_charAt		@; Call String_charAt
			
			ldr		r3, =cChar			@; Load into r3 the address of cChar
			str		r0, [r3]			@; Store value in r0 into r3
			
			ldr		r0, =szStrCharAt	@; Load into r0 the address of szStrCharAt
			bl		putstring			@; Call putch macro to output  szStrCharAt
			ldr		r0, =cChar			@; Load into r0 the address of crCr
			bl		putch				@; Call putch macro to output
			ldr		r0, =szSingleQuote	@; Load into r0 the address of szSingleQuote
			bl		putstring			@; Call putch macro to output  szSingleQuote		
			
			ldr		r0, =cCr			@; Load into r0 the address of crCr
			bl		putch				@; Call putch macro to output
			ldr		r0, =cCr			@; Load into r0 the address of crCr
			bl		putch				@; Call putch macro to output
			
			@;----------------------------------------------------------
			@; 10. 	String_startsWith_1(s1,11,"hat.") = TRUE 		
			@;----------------------------------------------------------
						
Func_8:		/** Test str1 with "hat." **/		
						
			ldr		r0, =szStr1			@; Load into r0 the addr of szStr1
			mov		r1, #11				@; Position index: r1 = 11
			ldr		r2, =szTest10		@; Load into r1 the addr of szTest10
			
			bl		String_startsWith_1	@; Call String_startsWith_1	
			mov		r2, r0				@; Makes copy of return in r0 into r2
			
			ldr		r0, =szStrStartW1	@; Load into r0 the address of szStrStartW1
			bl		putstring			@; Call putch macro to output  szStrStartW1	
			
			cmp		r2, #0				@; Compare r2 and 0
			beq		Func_8_F			@; Branch to Func_8_F if r2 == 0
			bne		Func_8_T			@; Branch to Func_8_T if r2 != 0
			
Func_8_F:
			ldr		r0, =szFalse		@; Load into r0 the address of szFalse
			bl		putstring			@; Call putch macro to output  szFalse
			ldr		r0, =cCr			@; Load into r0 the address of crCr
			bl		putch				@; Call putch macro to output
			ldr		r0, =cCr			@; Load into r0 the address of crCr
			bl		putch				@; Call putch macro to output
			b		Func_9				@; Branch to Func_9
Func_8_T:					
			ldr		r0, =szTrue			@; Load into r0 the address of szTrue
			bl		putstring			@; Call putch macro to output  szTrue	
			ldr		r0, =cCr			@; Load into r0 the address of crCr
			bl		putch				@; Call putch macro to output
			ldr		r0, =cCr			@; Load into r0 the address of crCr
			bl		putch				@; Call putch macro to output
			b		Func_9				@; Branch to Func_9
			
			@;----------------------------------------------------------
			@; 11. 	String_startsWith_2(s1,"Cat") = TRUE	 		
			@;----------------------------------------------------------
			
Func_9:		/** Test str1 with "Cat" **/

			ldr		r0, =szStr1			@; Load into r0 the addr of szStr1
			ldr		r1, =szTest11		@; Load into r1 the addr of szTest11
			
			bl		String_startsWith_2	@; Call String_startsWith_2	
			mov		r2, r0				@; Makes copy of return in r0 into r2
			
			ldr		r0, =szStrStartW2	@; Load into r0 the address of szStrStartW2
			bl		putstring			@; Call putch macro to output  szStrStartW2	
			
			cmp		r2, #0				@; Compare r2 and 0		
			beq		Func_9_F			@; Branch to Func_9_F if r2 == 0
			bne		Func_9_T			@; Branch to Func_9_T if r2 != 0
			
Func_9_F:
			ldr		r0, =szFalse		@; Load into r0 the address of szFalse
			bl		putstring			@; Call putch macro to output  szFalse
			ldr		r0, =cCr			@; Load into r0 the address of crCr
			bl		putch				@; Call putch macro to output
			ldr		r0, =cCr			@; Load into r0 the address of crCr
			bl		putch				@; Call putch macro to output
			b		Func_10				@; Branch to Func_10
Func_9_T:					
			ldr		r0, =szTrue			@; Load into r0 the address of szTrue
			bl		putstring			@; Call putch macro to output  szTrue	
			ldr		r0, =cCr			@; Load into r0 the address of crCr
			bl		putch				@; Call putch macro to output
			ldr		r0, =cCr			@; Load into r0 the address of crCr
			bl		putch				@; Call putch macro to output
			b		Func_10				@; Branch to Func_10
			
			@;----------------------------------------------------------
			@; 12. 	String_endsWith(s1,"in the hat.") = TRUE		
			@;----------------------------------------------------------
			
Func_10:	/** Test str1 with "in the hat." **/
			
			ldr		r0, =szStr1			@; Load into r0 the addr of szStr1
			ldr		r1, =szTest12		@; Load into r1 the addr of szTest12
			
			bl		String_endsWith		@; Call String_endsWith
			mov		r2, r0				@; Makes copy of return in r0 into r2
			
			ldr		r0, =szStrEndW		@; Load into r0 the address of szStrEndW
			bl		putstring			@; Call putch macro to output  szStrEndW	
			
			cmp		r2, #0				@; Compare r2 and 0
			beq		Func_10_F			@; Branch to Func_10_F if r2 == 0
			bne		Func_10_T			@; Branch to Func_10_T if r2 != 0
			
Func_10_F:
			ldr		r0, =szFalse		@; Load into r0 the address of szFalse
			bl		putstring			@; Call putch macro to output  szFalse
			ldr		r0, =cCr			@; Load into r0 the address of crCr
			bl		putch				@; Call putch macro to output
			ldr		r0, =cCr			@; Load into r0 the address of crCr
			bl		putch				@; Call putch macro to output
			b		Member2				@; Branch to _end
Func_10_T:					
			ldr		r0, =szTrue			@; Load into r0 the address of szTrue
			bl		putstring			@; Call putch macro to output  szTrue	
			ldr		r0, =cCr			@; Load into r0 the address of crCr
			bl		putch				@; Call putch macro to output
			ldr		r0, =cCr			@; Load into r0 the address of crCr
			bl		putch				@; Call putch macro to output
			b		Member2				@; Branch to _end						
			
@;**********************************************************************
@; 					TESTING CASES 13 - 22 (Member 2)
@;**********************************************************************			
Member2:			
			@;----------------------------------------------------------
			@; 13. 	String_indexOf_1(s2,'g') = 7
			@;----------------------------------------------------------
			
			ldr		r0, =szStrIOf1		@; Load into r0 the address of szStrIOf1
			bl		putstring			@; Call putch macro to output  szStrIOf1			
			
			ldr		r0, =szStr2			@; Load the address of szStr2 into r0
			mov		r1, #'g'			@; Load 'g' into r1
			bl		String_indexOf_1	@; Call String_indexOf_1 to find the index of 'g'

			ldr		r1, =szIndex1		@; Load r1 with a string that can hold 4 bites
			bl		intasc32	 		@; Convert value iX into a string
	
			ldr		r0, =szIndex1		@; Load the string into r0
			bl		putstring	 		@; Print the string			
			
			ldr		r0, =cCr			@; Load into r0 the address of crCr
			bl		putch				@; Call putch macro to output
			ldr		r0, =cCr			@; Load into r0 the address of crCr
			bl		putch				@; Call putch macro to output
			
			@;----------------------------------------------------------
			@; 14. 	String_indexOf_2(s2,'g',9) = -1
			@;----------------------------------------------------------
			
			ldr		r0, =szStrIOf2		@; Load into r0 the address of szStrIOf2
			bl		putstring			@; Call putch macro to output  szStrIOf2						
			
			ldr		r0, =szStr2			@; Load the address of szStr2 into r0
			mov		r1, #'g'			@; Load 'g' into r1
			mov		r2, #9				@; Load 9 into r2
			bl		String_indexOf_2	@; Call String_indexOf_2 to find the index of 'g' staring  at index 9

			ldr		r1, =szIndex2		@; Load r1 with a string that can hold 4 bites
			bl		intasc32	 		@; Convert value iX into a string
	
			ldr		r0, =szIndex2		@; Load the string into r0
			bl		putstring	 		@; Print the string		
						
			ldr		r0, =cCr			@; Load into r0 the address of crCr
			bl		putch				@; Call putch macro to output
			ldr		r0, =cCr			@; Load into r0 the address of crCr
			bl		putch				@; Call putch macro to output
						
			@;----------------------------------------------------------
			@; 15. 	String_indexOf_3(s2,"eggs") = 6
			@;----------------------------------------------------------
			
			ldr		r0, =szStrIOf3		@; Load into r0 the address of szStrIOf3
			bl		putstring			@; Call putch macro to output  szStrIOf3
			
			ldr		r0, =szStr2			@; Load the address of szStr2 into r0
			ldr		r1, =szTest15		@; Load the address of szTest15 into r1
			bl		String_indexOf_3	@; Call String_indexOf_3 to find the index of szTest15
	
			ldr		r1, =szIndex3		@; Load r1 with a string that can hold 4 bites
			bl		intasc32	 		@; Convert value iX into a string
	
			ldr		r0, =szIndex3		@; Load the string into r0
			bl		putstring	 		@; Print the string
			
			ldr		r0, =cCr			@; Load into r0 the address of crCr
			bl		putch				@; Call putch macro to output
			ldr		r0, =cCr			@; Load into r0 the address of crCr
			bl		putch				@; Call putch macro to output
			
			@;----------------------------------------------------------
			@; 16. 	String_lastIndexOf_1(s2,'g') = 8
			@;----------------------------------------------------------
			
			ldr		r0, =szStrLIOf1		@; Load into r0 the address of szStrLIOf1
			bl		putstring			@; Call putch macro to output  szStrLIOf1
			
			ldr		r0, =szStr2			@; Load the address of szStr2 into r0
			mov		r1, #'g'			@; Load g into r1
			bl		String_lastIndexOf_1@; Call String_lastIndexOf_1 to find the last index of 'g'

			ldr		r1, =szLastIndex1	@; Load r1 with a string that can hold 4 bites
			bl		intasc32	 		@; Convert value iX into a string
	
			ldr		r0, =szLastIndex1	@; Load the string into r0
			bl		putstring	 		@; Print the string
			
			ldr		r0, =cCr			@; Load into r0 the address of crCr
			bl		putch				@; Call putch macro to output
			ldr		r0, =cCr			@; Load into r0 the address of crCr
			bl		putch				@; Call putch macro to output
			
			@;----------------------------------------------------------
			@; 17. 	String_lastIndexOf_2(s2,'g',6) = -1
			@;----------------------------------------------------------
			
			ldr		r0, =szStrLIOf2		@; Load into r0 the address of szStrLIOf2
			bl		putstring			@; Call putch macro to output  szStrLIOf2
			
			ldr		r0, =szStr2			@; Load the address of szStr2 into r0
			mov		r1, #'g'			@; Load g into r1
			mov		r2, #6				@; Load 6 into r2
			bl		String_lastIndexOf_2@; Call String_lastIndexOf_2 to find the last index of 'g'

			ldr		r1, =szLastIndex2	@; Load r1 with a string that can hold 4 bites
			bl		intasc32	 		@; Convert value iX into a string
	
			ldr		r0, =szLastIndex2	@; Load the string into r0
			bl		putstring	 		@; Print the string
			
			ldr		r0, =cCr			@; Load into r0 the address of crCr
			bl		putch				@; Call putch macro to output
			ldr		r0, =cCr			@; Load into r0 the address of crCr
			bl		putch				@; Call putch macro to output
			
			@;----------------------------------------------------------
			@; 18. 	String_lastIndexOf_3(s2,"egg") = 6
			@;----------------------------------------------------------
			
			ldr		r0, =szStrLIOf3		@; Load into r0 the address of szStrLIOf3
			bl		putstring			@; Call putch macro to output  szStrLIOf3
			
			ldr		r0, =szStr2			@; Load the address of szStr2 into r0
			ldr		r1, =szTest15		@; Load the address of szTest15 into r1
			bl		String_lastIndexOf_3@; Call String_lastIndexOf_1 to find the last index of szTest15

			ldr		r1, =szLastIndex3	@; Load r1 with a string that can hold 4 bites
			bl		intasc32	 		@; Convert value iX into a string
	
			ldr		r0, =szLastIndex3	@; Load the string into r0
			bl		putstring	 		@; Print the string
			
			ldr		r0, =cCr			@; Load into r0 the address of crCr
			bl		putch				@; Call putch macro to output
			ldr		r0, =cCr			@; Load into r0 the address of crCr
			bl		putch				@; Call putch macro to output
			
			@;----------------------------------------------------------
			@; 19. 	String_replace(s1,'a','o') = "Cot in the hot."
			@;----------------------------------------------------------
			
			ldr		r0, =szStrReplace	@; Load into r0 the address of szStrReplace
			bl		putstring			@; Call putch macro to output  szStrReplace
			
			ldr		r0, =szStr1			@; Load the address of szStr1 into r0
			mov		r1, #'a'			@; Load 'a' into r1
			mov		r2, #'o'			@; Load 'o' into r2
			bl		String_replace		@; Call String_replace to replace all the 'a's with 'o's in szStr1

			mov 	r2, r0				@; Save the new string
			bl		putstring			@; Call putstring macro to output new string 
			
			ldr		r0, =cCr			@; Load into r0 the address of crCr
			bl		putch				@; Call putch macro to output
			ldr		r0, =cCr			@; Load into r0 the address of crCr
			bl		putch				@; Call putch macro to output
			
			@;----------------------------------------------------------
			@; 20. 	String_toLowerCase(s1) = "cot in the hot." 
			@;----------------------------------------------------------
			
			ldr		r0, =szStrLowerC	@; Load into r0 the address of szStrLowerC
			bl		putstring			@; Call putch macro to output  szStrLowerC
			
			mov		r0, r2				@; Load the address of szStr1 into r0
			bl		String_toLowerCase	@; Call String_toLowerCase to make szStr1 all lower case

			mov 	r2, r0				@; Save the new string
			bl		putstring			@; Call putstring macro to output new string
			
			ldr		r0, =cCr			@; Load into r0 the address of crCr
			bl		putch				@; Call putch macro to output
			ldr		r0, =cCr			@; Load into r0 the address of crCr
			bl		putch				@; Call putch macro to output
			
			@;----------------------------------------------------------
			@; 21. 	String_toUpperCase(s1) = "COT IN THE HOT."
			@;----------------------------------------------------------
			
			ldr		r0, =szStrUpperC	@; Load into r0 the address of szStrUpperC
			bl		putstring			@; Call putch macro to output  szStrUpperC
			
			mov		r0, r2				@; Load the address of szStr1 into r0
			bl		String_toUpperCase  @; Call String_toLowerCase to make szStr1 all upper case

			mov 	r2, r0				@; Save the new string
			bl		putstring			@; Call putstring macro to output new string
			
			ldr		r0, =cCr			@; Load into r0 the address of crCr
			bl		putch				@; Call putch macro to output
			ldr		r0, =cCr			@; Load into r0 the address of crCr
			bl		putch				@; Call putch macro to output
			
			@;----------------------------------------------------------
			@; 22. 	String_concat(s1, " ");
			@;		String_concat(s1, s2) = "COT IN THE HOT. Green eggs and ham."
			@;----------------------------------------------------------
			
			ldr		r0, =szStrConcat	@; Load into r0 the address of szStrConcat
			bl		putstring			@; Call putch macro to output  szStrConcat
			
			mov		r0, r2				@; Load the address of szStr1 into r0
			ldr		r1, =szTest22		@; Load the address of szTest22 into r1
			bl		String_concat		
			
			ldr		r1, =szStr2			@; Load the address of szStr2 into r1
			bl		String_concat		@; Call String_toLowerCase to make szStr1 all upper case
			
			bl		putstring			@; Call putstring macro to output new string
			
			ldr		r0, =cCr			@; Load into r0 the address of crCr
			bl		putch				@; Call putch macro to output
			ldr		r0, =cCr			@; Load into r0 the address of crCr
			bl		putch				@; Call putch macro to output
			
			
		/*****************
		 ** END PROGRAM **
		 *****************/	
_end:		mov 	r0, #0				@; Exit Status code set to 0 indicates "normal completion"
			mov 	r7, #1 				@; Service command code (1) will terminate this program
			svc 	0      				@; Issue Linux command to terminate program
		
			.end

