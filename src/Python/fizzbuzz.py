"""
FizzBuzz Implementation in Python 3
brtwrst - October 21, 2019

"Write a program that prints the numbers from 1 to 100. But for multiples of three print 
“Fizz” instead of the number and for the multiples of five print “Buzz”. For numbers which 
are multiples of both three and five print “FizzBuzz”."
"""

print('\n'.join(['Fizz' * (not i % 3) + 'Buzz' * (not i % 5) or str(i) for i in range(1, 101)]))
