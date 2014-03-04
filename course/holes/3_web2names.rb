#!/usr/bin/env ruby -w

class String

  WEB2_REGEX = Regexp.new(%q{
    ^                 # from the start of the string:
    (                 # capture ...
      \w*             # any alphanumeric character ...
      [AEIOUaeiou]+   # followed by one or more vowels ...
      \w+             # followed by one or more of any "word" character ...
      [^AEIOUaeiou]   # followed by a consonant.
    )
    [AEIOUaeiou]+     # match one or more of any vowel (we'll remove this)
    (r)               # finally match the letter r...
    $                 # if it's at the end of the string
  }, Regexp::EXTENDED)

  def web2ify
    result = match(WEB2_REGEX)
    if result
      modified_string = "#{result[1].to_s}#{result[2].to_s}"
    else
      modified_string = "#{self}"
    end
    return modified_string
  end

end

while name = gets do
  puts(name.strip.web2ify)
end
