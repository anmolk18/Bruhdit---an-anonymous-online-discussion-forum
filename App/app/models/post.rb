class Post < ApplicationRecord
    belongs_to :user
    has_many :post_tags
    has_many :tags, through: :post_tags
    # has_many :comments, through: :joiner
    # has_many :likes, through: :joiner
end
