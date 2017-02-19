class User < ApplicationRecord
  validates :email_address, presence: true
  validates :email_address, uniqueness: true
  validates_format_of :email_address, :with => /@/

  has_and_belongs_to_many :friendships,
     class_name: "User",
     join_table:  :friendships,
     foreign_key: :user_id,
     association_foreign_key: :friend_user_id
end
