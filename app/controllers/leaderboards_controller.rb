class LeaderboardsController < ApplicationController
    def index
        l = Leaderboard.new
        @top_5_players = l.top_5_players
        @top_5_loosers = l.top_5_loosers
        @best_ratio_players = l.best_ratio
        @total_games_played = l.total_games
        @easy_ai_games_total = l.easy_ai_games_total
        @medium_ai_games_total = l.medium_ai_games_total
        @hard_ai_games_total = l.hard_ai_games_total
        @players_games_total = l.players_games_total
    end
end
