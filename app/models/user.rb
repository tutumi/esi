class User < ApplicationRecord
  belongs_to :course

  VALID_NAME_REGEX = /\A[^0-9`!@#\$%\^&*+_=]+\z/
  validates :name, presence: true, length: { maximum: 50 }, format: { with: VALID_NAME_REGEX }
  validates :nusp, presence: true, length: { maximum: 7 }, numericality: { only_integer: true }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, length: { maximum: 255 },
          format: { with: VALID_EMAIL_REGEX }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
  has_and_belongs_to_many :curriculums
end
