class Leaderboard

  def teams
    Team.order(:total)
  end

  def hole_lengths
    holes.map(&:length)
  end

  def pars
    holes.map(&:par)
  end

  def bests
    holes.map(&:best)
  end

  def holes
    1.upto(18).map { |id| Hole.find_by_id id or NullHole.new }
  end

end
