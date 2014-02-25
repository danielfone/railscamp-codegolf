class Leaderboard

  def teams
    Team.order(:total)
  end

  def hole_lengths
    holes.map { |h| h.length }
  end

  def pars
    holes.map { |h| h.par }
  end

  def holes
    1.upto(18).map { |id| Hole.find_by_id id or NullHole.new }
  end

end
