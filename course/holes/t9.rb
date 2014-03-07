#!/usr/bin/env ruby -w

CHAR_MAP = {
  'a' => 2,
  'b' => 2,
  'c' => 2,
  'd' => 3,
  'e' => 3,
  'f' => 3,
  'g' => 4,
  'h' => 4,
  'i' => 4,
  'j' => 5,
  'k' => 5,
  'l' => 5,
  'm' => 6,
  'n' => 6,
  'o' => 6,
  'p' => 7,
  'q' => 7,
  'r' => 7,
  's' => 7,
  't' => 8,
  'u' => 8,
  'v' => 8,
  'w' => 9,
  'x' => 9,
  'y' => 9,
  'z' => 9,
}

STDIN.read.each_line do |line|
  new_line = ''
  line.each_char do |char|
    if CHAR_MAP.has_key? char
      new_char = CHAR_MAP[char]
    else
      new_char = char
    end
    new_line << new_char.to_s
  end
  puts new_line
end
