class LeaderboardsController < ApplicationController
    def index
        l = Leaderboard.new
        @top_5_players = l.top_5_players
        @top_5_loosers = l.top_5_loosers
        @best_ratio_players = l.best_ratio
    end
end
