class Post < ApplicationRecord
    belongs_to :user
    has_many :post_tags
    has_many :tags, through: :post_tags
    # has_many :comments, through: :joiner
    # has_many :likes, through: :joiner

    validates :title, presence: true
    validates :body, presence: true
    accepts_nested_attributes_for :tags, allow_destroy: true, reject_if: :all_blank
end
