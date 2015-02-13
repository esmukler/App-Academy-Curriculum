class Post < ActiveRecord::Base
  validates :title, :sub, :author, presence: true
  

end
