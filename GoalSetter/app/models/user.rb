class User < ActiveRecord::Base
    validates :username, :password_digest, :session_token, presence: true
    validates :username, :session_token, uniqueness: true
    after_initialize :ensure_session_token

    has_many(
      :goals,
      class_name: "Goal",
      foreign_key: :user_id,
      primary_key: :id
    )

    has_many(
      :authored_comments,
      class_name: "Comment",
      foreign_key: :author_id,
      primary_key: :id,
      inverse_of: :author
    )

    include Commentable

    attr_reader :password

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

    def is_password?(password)
      BCrypt::Password.new(self.password_digest).is_password?(password)
    end

    def ensure_session_token
      self.session_token ||= SecureRandom.urlsafe_base64(16)
    end

    def reset_session_token!
      self.session_token = SecureRandom.urlsafe_base64(16)
      self.save!
      self.session_token
    end

end
