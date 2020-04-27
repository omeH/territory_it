module Ratings
  class Calculator

    MIN_RATING = 1
    MAX_RATING = 5

    attr_reader :post

    def initialize(post:, value:)
      @post = post
      @value = value
    end

    def calculate
      post.total += value
      post.score = post.score.next
      post.average = post.total / post.score.to_f
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
