module TopRatings
  class Presenter

    MIN_LIMIT = 5
    MAX_LIMIT = 500

    attr_accessor :rating

    def initialize(limit: MIN_LIMIT)
      @limit = limit.to_i
    end

    def gather
      Post
        .top_rating(limit)
        .pluck(:title, :content)
    end

    def limit
      if @limit < MIN_LIMIT
        MIN_LIMIT
      elsif @limit > MAX_LIMIT
        MAX_LIMIT
      else
        @limit
      end
    end

  end
end
