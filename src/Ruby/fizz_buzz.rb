(1..100).each do |i|
  printable = [ i % 3 == 0 ? 'fizz' : nil,
                i % 5 == 0 ? 'buzz' : nil
              ].compact.join

  puts printable.empty? ? i : printable
end
