class ShortenedUrl < ActiveRecord::Base
  validates :short_url, :presence => true, :uniqueness => true
  validates :long_url, :presence => true
  validates :submitter_id, :presence => true

  belongs_to(
    :submitter,
    :class_name => "User",
    :foreign_key => :submitter_id,
    :primary_key => :id
  )

  has_many(
    :visits,
    class_name: "Visit",
    foreign_key: :visited_url_id,
    primary_key: :id
  )

  has_many :visitors, through: :visits, source: :visitor

  def self.random_code
    new_code = ''

    loop do
      new_code = SecureRandom.urlsafe_base64

      unless ShortenedUrl.exists?(new_code)
        break
      end
    end

    new_code
  end

  def self.create_for_user_and_long_url!(user, long_url)
    ShortenedUrl.new({short_url: ShortenedUrl.random_code,
                      submitter_id: user.id,
                      long_url: long_url})
  end

  def num_clicks
    Visit.where(visited_url_id: self.id).select(:id).count
  end

  def num_uniques
    Visit.where(visited_url_id: self.id).select(:visitor_id).distinct.count
  end

  def num_recent_uniques
    Visit.where(visited_url_id: self.id, updated_at: (10.minutes.ago..Time.now)).select(:visitor_id).distinct.count
  end


end
