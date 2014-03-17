class Leaderboard

  def hole_names
    holes.map(&:id)
  end

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
    Hole.find [19]
    #1.upto(18).map { |id| Hole.find_by_id id or NullHole.new }
  end

end
