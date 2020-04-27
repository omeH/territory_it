require 'actions/handler'
require 'posts/attributes_validator'

module Posts
  class Creator

    attr_accessor :post
    attr_reader :attributes, :handler, :validator

    delegate :on_success, :on_fail, to: :handler
    delegate :errors, to: :validator

    def initialize(attributes: {})
      @attributes = attributes

      @handler = Actions::Handler.new(action: self)
      @validator = Posts::AttributesValidator.new(attributes: attributes)
    end

    def create
      validator.validate
      return self if errors.any?

      # Firstly we just try to find user
      # If there is no user with provided login we try to create it
      user = User.find_by(login: attributes[:login])
      user ||= User.create_or_find_by(login: attributes[:login])

      self.post = Post.new(attributes.slice(:title, :content))
      post.user = user
      post.author = Author.new(ip: attributes[:ip])

      post.save!

      self
    end

  end
end
