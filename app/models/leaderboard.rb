class Leaderboard < ApplicationRecord
    def top_5_players
        User.all.sort_by{|user| user.wins.length}.reverse.first(5)
    end

    def top_5_loosers
        User.all.{|user| user.loses.length}.reverse[0..4]
    end

    def best_ratio
        User.all.sort_by{|user| user.ratio}.reverse.first(5)
    end

end
