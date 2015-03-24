require 'bcrypt'

class User < ActiveRecord::Base
  validates :username, :password_digest, presence: true

  after_initialize :generate_session_token

  has_many :cats,
    class_name: "Cat",
    foreign_key: :user_id,
    primary_key: :id

  has_many :requests,
    class_name: "CatRentalRequest",
    foreign_key: :user_id,
    primary_key: :id

  def reset_session_token!
    self.session_token = SecureRandom::urlsafe_base64
    self.save!
  end

  def password=(value)
    @password = value
    self.password_digest = BCrypt::Password.create(@password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest) == password
  end

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    return nil if user.nil?

    user.is_password?(password) ? user : nil
  end

  private

    def generate_session_token
      self.session_token ||= self.reset_session_token!
    end

end
