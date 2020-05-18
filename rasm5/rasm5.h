/****************************************************************************
 * AUTHOR:	Caroline Ta
 * ID:		1061262
 * CLASS:	CS 3B (Lab 21)
 * DATE:	05/13/2020
 ***************************************************************************/
#ifndef RASM5_H_
#define RASM5_H_

// EXTERNAL .s FILES
extern "C" int aBubbleSort(int a[], int length);
extern "C" int aInsertionSort(int a[], int length);

#include <iostream>
#include <fstream>	// Stream class to read/write from/to files
#include <iomanip>
#include <sstream>
#include <limits>
#include <ios>
#include <cstdlib>
#include <ctime>
#include <chrono>

using namespace std;
using namespace std::chrono; // using namesapce std::chrono


// FUNCTIONS
void OutToFile(const int a[], const int length, const string fileName);

// TIMER FUNCTIONS
double aBubbleTimer(int a[], const int length);
double cBubbleTimer(int a[], const int length);
double aInsertionTimer(int a[], const int length);
double cInsertionTimer(int a[], const int length);

// SORTING FUNCTIONS
void cBubbleSort(int a[], const int length);
void cInsertionSort(int a[], const int length);


#endif /* RASM5_H_ */
