#!/usr/bin/env ruby -w

@total = 0

while line = gets do
  numbers = line.scan(/\d+/)
  numbers = numbers.map { |number| number.to_i }
  numbers.each do |number|
    @total += number.to_i
  end
end

puts "#{@total.to_s}\n"
