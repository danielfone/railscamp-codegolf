class Leaderboard

  def columns
    %w[
      1
      2
      3
      4
      5
      6
      7
      8
      9
      IN
      10
      11
      12
      13
      14
      15
      16
      17
      18
      OUT
      Total
    ]
  end

  def references
    []
  end

  def teams
    Team.all
  end

end
