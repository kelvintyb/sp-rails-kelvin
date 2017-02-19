class User < ApplicationRecord
  validates :email, presence: true
  validates :email, uniqueness: true
  validates_format_of :email, :with => /@/

  has_many :friendships
  has_many :friend_users, through: :friendships, dependent: :destroy
end
