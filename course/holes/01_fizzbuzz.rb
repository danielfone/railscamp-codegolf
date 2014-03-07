#!/usr/bin/env ruby -w

class Numeric
  def multiple_of_5?
    self % 5 == 0
  end

  def multiple_of_3?
    self % 3 == 0
  end

  def multiple_of_15?
    multiple_of_5? and multiple_of_3?
  end
end

while line = gets do
  i = line.to_i
  if i.multiple_of_15?
    puts "FizzBuzz"
  elsif i.multiple_of_5?
    puts "Buzz"
  elsif i.multiple_of_3?
    puts "Fizz"
  else
    puts "#{i.to_s}"
  end
end
