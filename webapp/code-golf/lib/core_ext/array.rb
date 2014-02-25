class Array

  def coercive_sum
    map(&:to_i).sum unless compact.empty?
  end

end
