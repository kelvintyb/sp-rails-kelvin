class User < ApplicationRecord
  validates :email, presence: true
  validates :email, uniqueness: true
  validates_format_of :email, :with => /@/

  has_many :friendships
  has_many :friend_users, through: :friendships, dependent: :destroy

  has_many :active_subscriptions,  class_name:  "Subscription",
                                   foreign_key: "subscriber_id",
                                   dependent:   :destroy
  has_many :passive_subscriptions, class_name:  "Subscription",
                                   foreign_key: "subscribed_id",
                                   dependent:   :destroy
  has_many :subscribing, through: :active_subscriptions,  source: :subscribed
  has_many :subscribers, through: :passive_subscriptions

  has_many :active_blockades,  class_name:  "Blockade",
                                   foreign_key: "blocker_id",
                                   dependent:   :destroy
  has_many :passive_blockades, class_name:  "Blockade",
                                   foreign_key: "blocked_id",
                                   dependent:   :destroy
  has_many :blocking, through: :active_blockades,  source: :blocked
  has_many :blockers, through: :passive_blockades

  def friend_emails
    friend_users.map(&:email)
  end

  def subscribe_to(other_user)
    subscribing << other_user
  end

  def block(other_user)
    blocking << other_user
  end

  def blocking?(other_user)
    blocking.include?(other_user)
  end
  #
  # def following?(other_user)
  #   following.include?(other_user)
  # end

end
