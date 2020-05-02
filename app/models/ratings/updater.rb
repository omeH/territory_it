module Ratings
  class Updater

    attr_accessor :post, :errors
    attr_reader :post_id, :value

    delegate :on_success, :on_fail, to: :@handler

    def initialize(post_id:, value:)
      @post_id = post_id
      @value = value.to_i

      @handler = Actions::Handler.new(action: self)
    end

    def update
      ApplicationRecord.connection.transaction do
        self.post = Post.lock.find_by(id: post_id)

        if post
          Ratings::Calculator.new(post: post, value: value).calculate
          post.save!
        else
          self.errors = [I18n.t('record.not_found', record: I18n.t('record.post'), id: post_id)]
        end
      end

      self
    end

  end
end
