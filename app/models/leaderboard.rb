class Leaderboard < ApplicationRecord
    def top_5_players
        User.all.sort_by{|user| user.wins.length}.reverse.first(5)
    end

    def top_5_loosers
        User.all.sort_by{|user| user.loses.length}.reverse.first(5)
    end

    def best_ratio
        arr = User.all.sort_by do |user|
          user.ratio || 0
        end
        arr.reverse.first(5)
    end

    def total_games
        Room.all.reject(&:active?).count 
    end

    def easy_ai_games_total
        easy_ai = User.all.find_by(username: "EasyAI")
        easy_ai.total.count
    end

    def hard_ai_games_total
        hard_ai = User.all.find_by(username: "HardAI")
        hard_ai.total.count
    end

    def players_games_total
        players_games_total = total_games - (easy_ai_games_total + hard_ai_games_total)
    end

end
