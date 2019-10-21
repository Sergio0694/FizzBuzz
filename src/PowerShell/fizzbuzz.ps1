# FizzBuzz Implementation in PowerShell
# ijsankar - October 21, 2019
# 
# "Write a program that prints the numbers from 1 to 100. But for multiples of three print 
# "Fizz" instead of the number and for the multiples of five print "Buzz". For numbers which 
# are multiples of both three and five print "FizzBuzz"."

for($i=1;$i-ne 101;$i++){
 write-host $(If(!($i%15)){"FizzBuzz"} ElseIf(!($i%5)){"Buzz"} ElseIf(!($i%3)){"Fizz"} Else {$i} )
 }
