class Cat < ActiveRecord::Base
  COLORS = %w(calico tuxedo neon hairless)
  SEX = %w(M F)

  validates :birth_date, :color, :name, :sex, :description, :user_id, presence: true
  validates :color, inclusion: { in: COLORS }
  validates :sex,   inclusion: { in: SEX }

  has_many :rental_requests,
    class_name: "CatRentalRequest",
    foreign_key: :cat_id,
    primary_key: :id

  belongs_to :owner,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id

  def age
    years = (Date.today - birth_date).to_i / 365
    days = (Date.today - birth_date).to_i % 365
    "#{years} years and #{days} days"
  end

  def active_requests
    self.rental_requests.where.not(status: "DENIED")
                        .where("end_date >= ?", Date.today)
                        .order(:start_date)
  end

end
