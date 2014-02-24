#!/usr/bin/env ruby -w

h,r,d={73=>1,86=>5,88=>10,76=>50,67=>100,68=>500,77=>1000,10=>0},gets,0
(0..~/$/-1).map{|n|x=h[r[n]];d+=x<h[r[n+1]]?(-x):x}
p d

exit

class RomanNumeral
  NUMERAL_INTEGER = {
    I:  1,
    V:  5,
    X:  10,
    L:  50,
    C:  100,
    D:  500,
    M:  1000
  }

  def self.from_decimal(i)

  end

  def initialize(roman_numeral)
    @roman_numeral = roman_numeral if validates?(roman_numeral)
  end


  def to_integer
    numerals.inject(0) do |total, numeral|
      @current_numeral = numeral
      if subtract_numeral_from_total?
        total - numeral_to_integer
      else
        total + numeral_to_integer
      end
    end
  end

  def validates?(roman_numeral)
    thousands, hundreds, tens, units = 'M{0,3}', '(CM|CD|D?C{0,3})', '(XC|XL|L?X{0,3})', '(IX|IV|V?I{0,3})'
    valid_numeral_pattern = /^#{thousands}#{hundreds}#{tens}#{units}$/
    roman_numeral =~ valid_numeral_pattern ? true : fail(RomanNumeralError, 'Roman numeral is invalid')
  end

  def numerals
    @numerals ||= @roman_numeral.split('')
  end

  def subtract_numeral_from_total?
    has_next_numeral? &&
    next_numeral_is_greater?
  end

  def has_next_numeral?
    !@current_numeral.equal?(numerals.last)
  end

  def next_numeral_is_greater?
    numeral_to_integer < numeral_to_integer(next_numeral)
  end

  def next_numeral
    numerals[(numerals.index { |n| n.equal? @current_numeral } + 1)]
  end

  def numeral_to_integer(numeral = @current_numeral)
    NUMERAL_INTEGER[numeral.to_sym]
  end
end

class RomanNumeralError < StandardError; end

class Integer
  def to_roman
    RomanNumeral.from_decimal(self).to_s
  end
end

1000.times do |i|
  puts i.to_roman
end