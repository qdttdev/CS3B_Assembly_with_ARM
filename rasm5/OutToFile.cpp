/****************************************************************************
 * AUTHOR:	Caroline Ta
 * ID:		1061262
 * CLASS:	CS 3B (Lab 21)
 * DATE:	05/13/2020
 ***************************************************************************/
#include "rasm5.h"

void OutToFile(const int a[], const int length, const string fileName)
{
	//cerr << "@@@ I'm HERE!!! @@@";

	ofstream File(fileName);

	int i = 0;

	while(i < length)
	{
		File << a[i] << endl;

		i++;
	}

	File.close();
}




