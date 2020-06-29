class User < ApplicationRecord
    has_many :posts
    has_secure_password
    # has_many :comments
    # has_many :likes
    # has_many :tags, through: :posts
    # has_many :messages
    validates :user_name, uniqueness: true
end
