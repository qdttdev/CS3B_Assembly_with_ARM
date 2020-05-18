/****************************************************************************
 * AUTHOR:	Caroline Ta
 * ID:		1061262
 * CLASS:	CS 3B (Lab 21)
 * DATE:	05/13/2020
 ***************************************************************************/
#include "rasm5.h"

void cBubbleSort (int a[], const int length)
{
	int i, j, temp;

    for (i = 0; i < length; i++)
    {
        for (j = 0; j < length - i - 1; j++)
        {
            if (a[j + 1] < a[j])
            {
                temp = a[j];
                a[j] = a[j + 1];
                a[j + 1] = temp;
            }
        }
    }
}



