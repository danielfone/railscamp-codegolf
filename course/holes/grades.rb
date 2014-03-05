#!/usr/bin/env ruby -w

STDIN.read.each_line do |line|
  score = line.to_f

  case score
  when 90.00..100.00 then
    puts 'A'
  when 80.00..89.99 then
    puts 'B'
  when 70.00..79.99 then
    puts 'C'
  when 60.00..69.99 then
    puts 'D'
  when 50.00..59.99 then
    puts 'E'
  when  0.00..49.99 then
    puts 'F'
  else
    puts '?'
  end

end
