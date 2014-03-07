#!/usr/bin/env ruby -w

# From the strong_password gem
# https://github.com/bdmac/strong_password

# NIST Special Publication 800-63 suggests the following scheme to roughly estimate the entropy of human-generated passwords:[2]
# The entropy of the first character is four bits;
# The entropy of the next seven characters are two bits per character;
# The ninth through the twentieth character has 1.5 bits of entropy per character;
# Characters 21 and above have one bit of entropy per character.
# A "bonus" of six bits is added if both upper case letters and non-alphabetic characters are used.
# A "bonus" of six bits is added for passwords of length 1 through 19 characters following an extensive dictionary check to ensure the password is not contained within a large dictionary. Passwords of 20 characters or more do not receive this bonus because it is assumed they are pass-phrases consisting of multiple dictionary words.

module StrongPassword
  module NistBonusBits
    @@bonus_bits_for_password = {}
  
    # NIST password strength rules allow up to 6 bonus bits for mixed case and non-alphabetic
    def self.bonus_bits(password)
      @@bonus_bits_for_password[password] ||= begin
        calculate_bonus_bits_for(password)
      end
    end
  
    # This smells bad as it's only used for testing...
    def self.reset_bonus_cache!
      @@bonus_bits_for_password = {}
    end
  
    def self.calculate_bonus_bits_for(password)
      upper   = !!(password =~ /[[:upper:]]/)
      lower   = !!(password =~ /[[:lower:]]/)
      numeric = !!(password =~ /[[:digit:]]/)
      other   = !!(password =~ /[^a-zA-Z0-9 ]/)
      space   = !!(password =~ / /)
    
      bonus_bits = if upper && lower && other && numeric
        6
      elsif upper && lower && other && !numeric
        5
      elsif numeric && other && !upper && !lower
        -2
      elsif numeric && !other && !upper && !lower
        -6
      else
        0
      end

      if !space
        bonus_bits = bonus_bits - 2
      elsif password.split(/ /).length > 3
        bonus_bits = bonus_bits + 1
      end
      bonus_bits
    end
  end

  module EntropyCalculator
    # Calculates NIST entropy for a password.
    def self.calculate(password, repeats_weakened = false)
      if repeats_weakened
        bits_with_repeats_weakened(password)
      else
        bits(password)
      end
    end
    
    # The basic NIST entropy calculation is based solely
    # on the length of the password in question.
    def self.bits(password)
      length = password.length
      bits = if length > 20
        4 + (7 * 2) + (12 * 1.5) + length - 20
      elsif length > 8
        4 + (7 * 2) + ((length - 8) * 1.5)
      elsif length > 1
        4 + ((length - 1) * 2)
      else
        (length == 1 ? 4 : 0)
      end
      bits.to_f + NistBonusBits.bonus_bits(password)
    end
    
    # A modified version of the basic entropy calculation
    # which lowers the amount of entropy gained for each
    # repeated character in the password
    def self.bits_with_repeats_weakened(password)
      resolver = EntropyResolver.new
      bits = password.chars.each.with_index.inject(0) do |result, (char, index)|
        char_value = resolver.entropy_for(char)
        result += bit_value_at_position(index, char_value)
      end
      bits + NistBonusBits.bonus_bits(password)
    end
  
  private
    
    def self.bit_value_at_position(position, base = 1)
      if position > 19
        return base
      elsif position > 7
        return base * 1.5
      elsif position > 0
        return base * 2
      else
        return 4
      end
    end
  
    class EntropyResolver
      BASE_VALUE = 1
      REPEAT_WEAKENING_FACTOR = 0.75
      
      attr_reader :char_multiplier
      
      def initialize
        @char_multiplier = {}
      end
      
      # Returns the current entropy value for a character and weakens the entropy
      # for future calls for the same character.
      def entropy_for(char)
        ordinal_value = char.ord
        char_multiplier[ordinal_value] ||= BASE_VALUE
        char_value = char_multiplier[ordinal_value]
        # Weaken the value of this character for future occurrances
        char_multiplier[ordinal_value] = char_multiplier[ordinal_value] * REPEAT_WEAKENING_FACTOR
        return char_value
      end
    end
  end
end

STDIN.read.each_line do |password|
  puts StrongPassword::EntropyCalculator.calculate password
end
