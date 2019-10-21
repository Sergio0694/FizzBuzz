/*
* FizzBuzz Implementation in JavaScript
* The Sharp Ninja - October 20, 2019
*
* "Write a program that prints the numbers from 1 to 100. But for multiples of three print 
* “Fizz” instead of the number and for the multiples of five print “Buzz”. For numbers which 
* are multiples of both three and five print “FizzBuzz”."
*/

for (var i = 1; i <= 100; ++i) {
    console.log(i % 3 == 0
        ? i % 5 == 0
            ? "FizzBuzz"
            : "Fizz"
        : i % 5 == 0
            ? "Buzz"
            : i
    );
}
