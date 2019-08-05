class User < ApplicationRecord
    validates :session_token, :username, presence: true, uniqueness: true 
    validates :password_digest, presence: true
    validates :password, length: { minimum: 6 }, allow_nil: true
 
  attr_reader :password
  after_initialize :ensure_session_token

  def self.find_by_credentials(user_name, password)
    user = User.find_by(username: user_name)
    return nil unless user
    user.is_password?(password) ? user : nil
  end

  def reset_session_token!
    self.session_token = SecureRandom::urlsafe_base64
    self.save!
    self.session_token
  end

  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
    @password = password
  end

  def is_password(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def ensure_session_token
      self.session_token ||= SecureRandom::urlsafe_base64
  end
end
