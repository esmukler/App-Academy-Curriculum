class User < ActiveRecord::Base
  after_initialize :ensure_session_token

  validates :username, :session_token, :password_digest, presence: true
  validates :username, :session_token, uniqueness: true
  validates :password, length: {minimum: 6}, allow_nil: true

  has_many :moderated_subs,
  class_name: "Sub",
  foreign_key: :moderator_id,
  primary_key: :id,
  inverse_of: :moderator

  has_many :authored_posts,
  class_name: "Post",
  foreign_key: :author_id,
  primary_key: :id,
  inverse_of: :author

  def self.find_by_credentials(username, password)
    user = User.find_by_username(username)
    return nil if user.nil?

    if user.is_password?(password)
      return user
    else
      return nil
    end
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def password
    @password
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def reset_session_token!
    self.session_token = SecureRandom.base64
    self.save!
    self.session_token
  end

  private

    def ensure_session_token
      self.session_token ||= SecureRandom.base64
    end
end
