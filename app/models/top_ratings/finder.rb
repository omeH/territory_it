module TopRatings
  class Finder

    MIN_LIMIT = 1

    attr_accessor :rating

    def initialize(limit: MIN_LIMIT)
      @limit = limit.to_i
    end

    def find
      Post
        .top_rating(limit)
        .pluck(:title, :content)
    end

    def limit
      @limit.zero? || @limit.negative? ? MIN_LIMIT : @limit
    end

  end
end
