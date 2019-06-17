class Leaderboard < ApplicationRecord
    def top_5_players
        User.all.sort_by{|user| user.wins.length}.reverse.first(5)
    end

    def top_5_loosers
        User.all.sort_by{|user| user.wins.length}.first(5)
    end
end
