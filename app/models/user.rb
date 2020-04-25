class User < ApplicationRecord

  has_many :authors
  has_many :posts

end
