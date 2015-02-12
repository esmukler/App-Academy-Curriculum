class Album < ActiveRecord::Base
  SETTINGS = %w(studio live)

  validates :name, :band_id, :setting, presence: true

  belongs_to :band

  has_many :tracks

end
