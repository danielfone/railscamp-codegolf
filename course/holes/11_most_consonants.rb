#!/usr/bin/env ruby -w

CONSONANTS = ["b", "c", "d", "f", "g", "h",
              "j", "k", "l", "m", "n", "p",
              "q", "r", "s", "t", "v", "w",
              "x", "y", "z"]

consonant_counts = Array.new

while line = gets do
  line_consonants = line.each_char.select { |char| CONSONANTS.include? char }
  consonant_counts << [line, line_consonants.length]
end

sorted = consonant_counts.sort_by do |word, count|
  count
end

puts sorted.last.first
