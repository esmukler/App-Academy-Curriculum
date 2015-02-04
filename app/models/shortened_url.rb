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

end
