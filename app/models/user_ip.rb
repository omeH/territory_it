class UserIp < ApplicationRecord

  belongs_to :user

  scope :by_logins, ->(logins) { joins(:user).where(users: { login: logins }) }

end
