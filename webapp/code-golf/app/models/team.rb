class Team < ActiveRecord::Base

  def score
    Array.new(18, 0)
  end

  def front_nine
    score[1..9].sum
  end

  def back_nine
    score[10..18].sum
  end

  def total
    score.sum
  end


end
