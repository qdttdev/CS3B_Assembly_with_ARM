/****************************************************************************
 * AUTHOR:	Caroline Ta
 * ID:		1061262
 * CLASS:	CS 3B (Lab 21)
 * DATE:	05/13/2020
 ***************************************************************************/
#include "rasm5.h"

double cInsertionTimer(int a[], const int length)
{
	/*************
	 * CONSTANTS *
	 *************/
	const long long TIMES = 1; // Number of times run for Iteration

	/*************
	 * VARIABLES *
	 *************/
	double temp;	// CALC & OUT - Template to hold time measurement
	long long run;  // CALC		  - Count for times run

	/**************************************************************************
	 * PROCESSING - Iteration time measure (Chrono Library Test)
	 *************************************************************************/
	high_resolution_clock::time_point t5 = high_resolution_clock::now();

	for(run = 0; run < TIMES; run++)
	{
		cInsertionSort(a, length);
	}

	high_resolution_clock::time_point t6 = high_resolution_clock::now();

	OutToFile(a, length, "c_output_Insertion.txt");

	auto duration6a = duration_cast<microseconds>(t6 - t5).count();

	temp = duration6a * 0.000001;

	cout << "\nIt took the program "
		 << setprecision (10)
		 << fixed
		 << temp/TIMES
		 << " seconds to execute C Insertion Sort function.\n";

	return temp/TIMES;
}

