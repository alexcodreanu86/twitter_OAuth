class User < ActiveRecord::Base
  validates :username, uniqueness: true
  # Remember to create a migration!
end
