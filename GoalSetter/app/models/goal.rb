class Goal < ActiveRecord::Base
  STATUS = [ "COMPLETE", "INCOMPLETE" ]
  AVAILABILITY = [ "PUBLIC", "PRIVATE" ]

  validates :name, :status, :user_id, :availability, presence: true
  validates_inclusion_of :status, in: STATUS
  validates_inclusion_of :availability, in: AVAILABILITY

  belongs_to(
    :user,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id
  )

  include Commentable

end
