class Comment < ActiveRecord::Base
  validates :content, :author, :post, presence: true

  belongs_to :post,
  inverse_of: :comments

  belongs_to :author,
  class_name: "User",
  foreign_key: :author_id,
  primary_key: :id,
  inverse_of: :comments

  has_many :child_comments,
  class_name: "Comment",
  foreign_key: :parent_comment_id,
  primary_key: :id

  has_one :parent_comment,
  class_name: "Comment",
  foreign_key: :parent_comment_id,
  primary_key: :id




end
