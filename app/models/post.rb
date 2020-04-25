class Post < ApplicationRecord

  belongs_to :user
  has_one :author
  has_one :rating

end
