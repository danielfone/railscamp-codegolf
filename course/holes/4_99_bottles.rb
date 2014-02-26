#!/usr/bin/env ruby -w

class NilClass
  def try
    nil
  end
end

class String
  def try(method_name)
    public_send method_name
  end

  def strip_heredoc
    indent = scan(/^[ \t]*(?=\S)/).min.try(:size) || 0
    gsub(/^[ \t]{#{indent}}/, '')
  end

  def pluralize(count = nil)
    if count == 1
      self
    else
      self+'s'
    end
  end
end

def pluralize(count, noun)
  "#{count} #{noun.pluralize count}"
end

numbers = (1 .. 99).to_a
numbers.reverse.each do |number|
  if number > 1
    puts <<-POEM.strip_heredoc
      #{pluralize number, 'bottle'} of beer on the wall, #{pluralize number, 'bottle'} of beer.
      Take one down and pass it around, #{pluralize number-1, 'bottle'} of beer on the wall.

    POEM
  else
    puts <<-POEM.strip_heredoc
      #{pluralize number, 'bottle'} of beer on the wall, #{pluralize number, 'bottle'} of beer.
      Go to the store and buy some more, 99 bottles of beer on the wall.
    POEM
  end
end
