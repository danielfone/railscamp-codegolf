class Team < ActiveRecord::Base

  serialize :scores, JSON

  after_initialize :setup_defauls

  def score_for(hole)
    scores[hole-1]
  end

  def front_nine
    sum_scores scores[0..8]
  end

  def back_nine
    sum_scores scores[9..17]
  end

  def total
    sum_scores scores
  end

private

  def sum_scores(array)
    array.map(&:to_i).sum unless array.compact.empty?
  end

  def setup_defauls
    self.scores ||= Array.new(18, nil)
  end

end
