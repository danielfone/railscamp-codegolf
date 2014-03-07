#!/usr/bin/env ruby -w

def sanitize(line)
  sanitized = line.chomp
  sanitized = sanitized.tr '^A-Za-z0-9', ''
  sanitized = sanitized.tr 'a-z', 'A-Z'
end


STDIN.read.each_line do |line|
  sanitized = sanitize line

#  puts "#{line.chomp} => #{sanitized}"

  if sanitized == sanitized.reverse
    puts 'true'
  else
    puts 'false'
  end
end
