class Leaderboard

  def teams
    Team.order(:total)
  end

  def hole_lengths
    18.times.each.map { rand 2000 }
  end

  def pars
    18.times.each.map { rand 100 }
  end

end
