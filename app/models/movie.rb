class Movie < ActiveRecord::Base

    def self.ratings
        ratings= []
        Movie.select(:rating).uniq.each do |m|
            ratings << m.rating
        end
        ratings.uniq
    end

end
