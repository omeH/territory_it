module Posts
  class Presenter

    attr_reader :post

    def initialize(post:)
      @post = post
    end

    def gather
      {
        id: post.id,
        title: post.title,
        content: post.content,
        ip: post.author&.ip.to_s
      }
    end

  end
end
