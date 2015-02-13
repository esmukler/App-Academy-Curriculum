class Sub < ActiveRecord::Base
  validates :title, :description, :moderator, presence: true

  belongs_to :moderator,
  class_name: "User",
  foreign_key: :moderator_id,
  primary_key: :id,
  inverse_of: :moderated_subs

  # has_many :posts,
  # class_name: "Post",
  # foreign_key: :sub_id,
  # primary_key: :id,
  # inverse_of: :sub

  has_many :post_subs,
  class_name: "PostSub",
  foreign_key: :sub_id,
  primary_key: :id,
  inverse_of: :sub

  has_many :posts,
  through: :post_subs,
  source: :post
end
