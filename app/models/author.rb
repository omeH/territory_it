class Author < ApplicationRecord

  belongs_to :post
  belongs_to :user

  scope :by_logins, ->(logins) { joins(:user).where(users: { login: logins }) }

end
