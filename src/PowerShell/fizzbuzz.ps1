for($i=1;$i-ne 101;$i++){
 write-host $(If(!($i%15)){"FizzBuzz"} ElseIf(!($i%5)){"Buzz"} ElseIf(!($i%3)){"Fizz"} Else {$i} )
 }
