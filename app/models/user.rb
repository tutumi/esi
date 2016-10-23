class User < ApplicationRecord
    validates :name, presence: true, length: { maximum: 50 }
    validates :nusp, presence: true, length: { maximum: 7 }
    validates :email, length: { maximum: 255 }
end
