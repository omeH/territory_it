require 'ratings/calculator'

module Ratings
  class Updater

    attr_accessor :rating, :errors
    attr_reader :post_id, :value

    delegate :on_success, :on_fail, to: :@handler

    def initialize(post_id:, value:)
      @post_id = post_id
      @value = value.to_i

      @handler = Actions::Handler.new(action: self)
    end

    def update
      ApplicationRecord.connection.transaction do
        self.rating = Rating.lock.find_by(post_id: post_id)

        if rating
          Ratings::Calculator.new(rating: rating, value: value).calculate
          rating.save!
        else
          self.errors = [I18n.t('record.not_found', record: I18n.t('post.name'), id: post_id)]
        end
      end

      self
    end

  end
end
