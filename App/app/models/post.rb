class Post < ApplicationRecord
    belongs_to :user
    has_many :post_tags
    has_many :tags, through: :post_tags
    has_many :comments, dependent: :destroy
    has_many :likes, dependent: :destroy

    validates :title, presence: true
    validates :body, presence: true
    accepts_nested_attributes_for :tags, allow_destroy: true, reject_if: :all_blank
end
