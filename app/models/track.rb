class Track < ActiveRecord::Base
  STATUS = %w(regular bonus)

  validates :name, :album_id, :status, presence: true

  belongs_to :album

  has_one :band, through: :album

end
