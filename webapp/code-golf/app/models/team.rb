class Team < ActiveRecord::Base

  serialize :scores, JSON

  after_initialize :setup_defauls
  before_save :store_total

  def score_for(hole)
    scores[hole-1]
  end

  def front_nine
    scores[0..8].coercive_sum
  end

  def back_nine
    scores[9..17].coercive_sum
  end

  def total
    scores.coercive_sum
  end

private

  def setup_defauls
    self.scores ||= Array.new(18, nil)
  end

  def store_total
    write_attribute :total, total
  end

end
