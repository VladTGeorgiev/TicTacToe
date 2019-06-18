class LeaderboardsController < ApplicationController
    def index
        @top_5_players = Leaderboard.new.top_5_players
        @top_5_loosers = Leaderboard.new.top_5_loosers
        @best_ratio_players = Leaderboard.new.best_ratio
    end
end
