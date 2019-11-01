##
# FizzBuzz Implementation in Ruby
# paschoal - October 21, 2019
# 
# "Write a program that prints the numbers from 1 to 100. But for multiples of three print 
# "Fizz" instead of the number and for the multiples of five print "Buzz". For numbers which 
# are multiples of both three and five print "FizzBuzz"."

(1..100).each do |i|
  printable = [ i % 3 == 0 ? 'Fizz' : nil,
                i % 5 == 0 ? 'Buzz' : nil
              ].compact.join

  puts printable.empty? ? i : printable
end
