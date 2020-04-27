class Post < ApplicationRecord

  belongs_to :user
  has_one :author

  scope :top_rating, -> (limit) { order(average: :desc).limit(limit) }

end
