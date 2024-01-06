class User < ApplicationRecord
  has_secure_password :password, validations: true

  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 6 }
  validates :password, format: { with: /[a-z]{1,}/, message: "must contain at least one lowercase letter" }
  validates :password, format: { with: /[A-Z]{1,}/, message: "must contain at least one uppercase letter" }
  validates :password, format: { with: /[0-9]{1,}/, message: "must contain at least one number" }
  validates :password, format: { with: /[!@#$%^&*-+=]{1,}/, message: "must contain at least one special character: " }
end
