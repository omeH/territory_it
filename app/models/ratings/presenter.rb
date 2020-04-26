module Ratings
  class Presenter

    attr_reader :rating

    def initialize(rating:)
      @rating = rating
    end

    def gather
      {
        rating: rating.average&.round(2)
      }
    end

  end
end
