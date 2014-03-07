#!/usr/bin/env ruby -w

class String

  def is_anagram?(other)
    char_counts == other.char_counts
  end

  def char_counts
    chars.inject Hash.new(0) do |accumulator, char|
      accumulator[char] += 1
      accumulator
    end
  end

end

first_word  = gets
second_word = gets if first_word

while first_word && second_word do

  if first_word.is_anagram? second_word
    puts "true"
  else
    puts "false"
  end

  first_word  = gets
  second_word = gets if first_word
end
