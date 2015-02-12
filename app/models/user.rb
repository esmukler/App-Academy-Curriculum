class User < ActiveRecord::Base
  validates :email, :password_digest, :session_token, presence: true
  # validates :password, { length: 6, :allow_nil }
  after_initialize :ensure_session_token

  def self.find_by_credentials(email, password)
    user = User.find_by_email(email)
    return nil if user.nil?

    if user.is_password?(password)
      return user
    else
      return nil
    end
  end

  def password=(value)
    self.password_digest = BCrypt::Password.create(value)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest) == password
  end

  private

    def self.generate_session_token
      SecureRandom::urlsafe_base64(16)
    end

    def reset_session_token!
      self.session_token = self.class.generate_session_token
      self.save!
      self.session_token
    end

    def ensure_session_token
      self.session_token ||= self.class.generate_session_token
    end


end
