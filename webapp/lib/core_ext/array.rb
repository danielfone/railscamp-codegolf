class Array

  def coercive_sum
    map(&:to_int).sum rescue nil
  end

end
