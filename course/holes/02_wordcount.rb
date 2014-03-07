#!/usr/bin/env ruby -w

count = 0

while line = gets do
  words = line.split(' ')
  count += words.size
end

puts "#{count}"
