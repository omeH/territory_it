module Ratings
  class Presenter

    attr_reader :post

    def initialize(post:)
      @post = post
    end

    def gather
      {
        rating: post.average&.round(2)
      }
    end

  end
end
