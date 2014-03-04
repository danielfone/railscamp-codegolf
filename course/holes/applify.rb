#!/usr/bin/env ruby -w

while line = gets do
  word = line.chomp
  new_word = word[0].upcase + word[1..-1]
  puts "i" + new_word
end
