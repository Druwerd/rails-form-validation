class User < ApplicationRecord
  ALLOWED_PASSWORD_SPECIAL_CHARS = %w(! @ # $ % ^ & * _ + =).freeze

  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 12 }
  validates :password, format: { with: /[a-z]{1,}/, message: "must contain at least one lowercase letter" }
  validates :password, format: { with: /[A-Z]{1,}/, message: "must contain at least one uppercase letter" }
  validates :password, format: { with: /[0-9]{1,}/, message: "must contain at least one number" }
  validates :password, format: {
    with: /[#{ALLOWED_PASSWORD_SPECIAL_CHARS.join}]{1,}/,
    message: "must contain at least one special character: #{ALLOWED_PASSWORD_SPECIAL_CHARS.join(' ')}"
  }

  has_secure_password :password, validations: true
end
