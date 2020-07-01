class User < ApplicationRecord
    has_many :posts
    has_many :likes, dependent: :destroy
    has_many :comment_likes, dependent: :destroy
    has_secure_password
    # has_many :comments
    # has_many :likes
    # has_many :tags, through: :posts
    # has_many :messages
    validates :user_name, uniqueness: true
    validates :user_name, format: { with: /\A[a-zA-Z0-9]+\Z/ }
    validates :user_name, length: {minimum: 3, maximum: 30}
end
