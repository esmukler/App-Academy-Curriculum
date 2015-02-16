class Goal < ActiveRecord::Base
  validates :name, :status, :user_id, :availability, presence: true
  validates_inclusion_of :status, in: [ "COMPLETE", "INCOMPLETE" ]
  validates_inclusion_of :availability, in: [ "PUBLIC", "PRIVATE" ]

  belongs_to(
    :user,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id
    inverse_of: :user
  )

end
