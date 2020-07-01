class Comment < ApplicationRecord
    belongs_to :post
    belongs_to :user
    validates :body, presence: :true
    has_many :comment_likes, dependent: :destroy
end
