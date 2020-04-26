module Ratings
  class Calculator

    MIN_RATING = 1
    MAX_RATING = 5

    attr_reader :rating

    def initialize(rating:, value:)
      @rating = rating
      @value = value
    end

    def calculate
      rating.total += value
      rating.score = rating.score.next
      rating.average = rating.total / rating.score.to_f
    end

    def value
      if @value < MIN_RATING
        MIN_RATING
      elsif @value > MAX_RATING
        MAX_RATING
      else
        @value
      end
    end

  end
end
