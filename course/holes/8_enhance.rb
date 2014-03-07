#!/usr/bin/env ruby -w

class ASCIIEnhancer

  def self.enhance(*args)
    new(*args).enhance
  end

  def initialize(ascii, scaling_factor)
    @ascii          = ascii
    @scaling_factor = scaling_factor
  end

  def enhance
    enhance_y enhance_x
  end

private

  def enhance_x
    enhanced_self = ""
    @ascii.chomp.each_char do |char|
      1.upto(@scaling_factor) do |line_no|
        enhanced_self << char.to_s
      end
    end
    return enhanced_self + "\n"
  end

  def enhance_y(line)
    enhanced_self = ""
    1.upto(@scaling_factor) do |line_no|
      enhanced_self << line
    end
    return enhanced_self
  end

end

class String
  def enhance(scaling_factor)
    ::ASCIIEnhancer.enhance self, scaling_factor
  end
end


STDIN.read.each_line do |line|
  puts line.enhance 3
end
