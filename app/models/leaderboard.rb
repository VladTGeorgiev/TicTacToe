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

end
