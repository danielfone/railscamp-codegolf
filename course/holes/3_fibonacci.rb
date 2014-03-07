#!/usr/bin/env ruby -w

QUADRATIC_ZERO_ORDER_TERM = 4

class Numeric
  def is_a_fibonacci?
    quadratic_second_order_term = 5 * self**2
    positive_quadratic = quadratic_second_order_term + QUADRATIC_ZERO_ORDER_TERM
    negative_quadratic = quadratic_second_order_term - QUADRATIC_ZERO_ORDER_TERM
    positive_quadratic.is_a_perfect_square? or negative_quadratic.is_a_perfect_square?
  end

  def is_a_perfect_square?
    Math.sqrt(self).to_i == Math.sqrt(self)
  end

end


while line = gets do
  i = line.to_i
  if i.is_a_fibonacci?
    puts "y"
  else
    puts "n"
  end
end
