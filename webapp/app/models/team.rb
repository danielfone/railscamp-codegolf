class Team < ActiveRecord::Base

  serialize :scores, JSON

  after_initialize :setup_defauls

  validates :name, presence: true

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

  def clone_url
    "ssh://vagrant@#{Rails.configuration.hostname}:2222/chchruby/#{name}/codegolf.git"
  end

private

  def setup_defauls
    self.scores ||= Array.new(18, nil)
  end

  def store_total
    write_attribute :total, total
  end

end
