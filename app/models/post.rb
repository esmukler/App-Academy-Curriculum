class Post < ActiveRecord::Base
  validates :title, :subs, :author, presence: true

  # belongs_to :sub,
  # class_name: "Sub",
  # foreign_key: :sub_id,
  # primary_key: :id,
  # inverse_of: :posts

  belongs_to :author,
  class_name: "User",
  foreign_key: :author_id,
  primary_key: :id,
  inverse_of: :authored_posts

  has_many :post_subs,
  class_name: "PostSub",
  foreign_key: :post_id,
  primary_key: :id,
  inverse_of: :post

  has_many :subs,
  through: :post_subs,
  source: :sub


end
