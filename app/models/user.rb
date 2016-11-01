class User < ApplicationRecord
    validates :name, presence: true, length: { maximum: 50 }
    validates :nusp, presence: true, length: { maximum: 7 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, length: { maximum: 255 },
            format: { with: VALID_EMAIL_REGEX }
    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }

end
