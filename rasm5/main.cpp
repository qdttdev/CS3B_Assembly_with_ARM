/****************************************************************************
 * AUTHOR:	Caroline Ta
 * ID:		1061262
 * CLASS:	CS 3B (Lab 21)
 * DATE:	05/13/2020
 ***************************************************************************/
#include "rasm5.h"

int main()
{
	/***************
	 ** CONSTANTS **
	 ***************/
	// Ctrl + B: 	Build
	// Ctrl + F11: 	Run

	const int AR_SIZE = 200000;

	const string CLASS_HEADER = "********************************************"
								"***********************************\n"
								"* AUTHOR: Caroline Ta\n"
								"* ID:     1061262\n"
								"* CLASS:  CS 3B - RASM 5\n"
								"* DATE:   05/13/2020\n"
								"********************************************"
								"***********************************\n\n";

	const string TITLE = "\tRASM5: C++ vs Assembly\n";

	const string MENU = "<1> Load input file (integers)\n"
						"<2> Sort using C bubbleSort algorithm\n"
						"<3> Sort using Assembly bubbleSort\n"
						"<4> Sort using C insertionSort algorithm\n"
						"<5> Sort using Assembly insertionSort algorithm\n"
						"<6> Quit\n\n";

	const string BORDER	= "------------------------------------------------\n";


	/***************
	 ** VARIABLES **
	 ***************/
	fstream	fin;
	int		index		= 0;
	int		input		= 0;
	int		elemCount 	= 0;
	double 	cBubble 	= 0;
	double 	cInsertion 	= 0;
	double 	aBubble 	= 0;
	double 	aInsertion 	= 0;
	int		intArray1[AR_SIZE];
	int		intArray2[AR_SIZE];
	int		intArray3[AR_SIZE];
	int		intArray4[AR_SIZE];

	cout << CLASS_HEADER;

	do
	{
		cout << TITLE;
		cout << "\tFile Element Count: " << elemCount << endl;

		cout << endl << BORDER;

		cout << "C        bubbleSort    Time: "
			 << setprecision (10) << fixed
			 << cBubble << " secs\n";

		cout << "Assembly bubbleSort    Time: "
			 << setprecision (10) << fixed
			 << aBubble << " secs\n\n";

		cout << "C        insertionSort Time: "
			 << setprecision (10) << fixed
			 << cInsertion << " secs\n";

		cout << "Assembly insertionSort Time: "
			 << setprecision (10) << fixed
			 << aInsertion << " secs\n";

		cout << BORDER;
		cout << endl;

		cout << MENU;
		cout << "Enter choice: ";
		cin  >> input;
		cin.ignore();

		cout << endl << endl;

		if(input == 1)
		{
			fin.open("input.txt");

			while(!fin.eof())
			{
				fin >> intArray1[index];
				fin.ignore();

				intArray2[index] = intArray1[index];
				intArray3[index] = intArray1[index];
				intArray4[index] = intArray1[index];

				index++;
				elemCount++;
			}

			fin.close();

			cout << "\t>>> INPUT FILE WAS SUCCESSFULLY LOADED...\n";
		}// end of if(input == 1)

		else
		{
			switch(input)
			{
				case 2 :	cBubble = cBubbleTimer(intArray1, elemCount);
							cout << "\t>>> FILE WAS SORTED USING C BUBBLE "
									"SORT...\n";
					break;
				case 3 :	aBubble = aBubbleTimer(intArray2, elemCount);
							cout << "\t>>> FILE WAS SORTED USING ASSEMBLY "
									"BUBBLE SORT...\n";
					break;
				case 4 :	cInsertion = cInsertionTimer(intArray3, elemCount);
							cout << "\t>>> FILE WAS SORTED USING C INSERTION "
									"SORT...\n";
					break;
				case 5 :	aInsertion = aInsertionTimer(intArray4, elemCount);
							cout << "\t>>> FILE WAS SORTED USING ASSEMBLY "
									"INSERTION SORT...\n";
					break;
			} // end switch(input)
		} // end else of if(input == 1)

		if(input != 6)
		{
			// Idle Screen - Enter
			cout << "\t\t[Enter to continue]";
			cin.ignore();
		}

//		cout << endl << endl << endl << endl << endl;
//
//		cout << "\nAR 1: ";
//
//		for(int i = 0; i < elemCount; i++)
//		{
//			cout << intArray1[i] << " ";
//		}
//
//		cout << "\nAR 2: ";
//
//		for(int i = 0; i < elemCount; i++)
//		{
//			cout << intArray2[i] << " ";
//		}
//
//		cout << "\nAR 3: ";
//
//		for(int i = 0; i < elemCount; i++)
//		{
//			cout << intArray3[i] << " ";
//		}
//
//		cout << "\nAR 4: ";
//
//		for(int i = 0; i < elemCount; i++)
//		{
//			cout << intArray4[i] << " ";
//		}

		cout << endl << endl << endl << endl << endl;

	}while(input != 6);


	cout << "PROGRAM ENDED - THANK YOU FOR USING THE PROGRAM.\n";


	return 0;
}
