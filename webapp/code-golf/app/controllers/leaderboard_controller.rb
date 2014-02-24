class LeaderboardController < ApplicationController

  def show
    @board = Leaderboard.new
  end

end
