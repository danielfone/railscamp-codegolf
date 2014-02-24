class LeaderboardController < ApplicationController

  def show
    #@meta_refresh = 10
    @board = Leaderboard.new
  end

end
