/*
* FizzBuzz Implementation in C
* The Sharp Ninja - October 20, 2019
*
* "Write a program that prints the numbers from 1 to 100. But for multiples of three print 
* “Fizz” instead of the number and for the multiples of five print “Buzz”. For numbers which 
* are multiples of both three and five print “FizzBuzz”."
*/
#include <stdio.h>

int main()
{
    char snum[4];

    for (int i = 1; i <= 100; ++i)
    {
        itoa(i, snum, 10);
        printf("%s\n", i % 3 == 0
                   ? i % 5 == 0
                         ? "FizzBuzz"
                         : "Fizz"
                   : i % 5 == 0
                         ? "Buzz"
                         : snum);
    }
}
