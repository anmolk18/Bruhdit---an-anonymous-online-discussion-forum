class Post < ApplicationRecord
    belongs_to :user
    has_many :post_tags
    has_many :tags, through: :post_tags
    has_many :comments, dependent: :destroy
    has_many :likes, dependent: :destroy

    validates :title, presence: true
    validates :body, presence: true
    accepts_nested_attributes_for :tags, allow_destroy: true, reject_if: :all_blank

    def self.like_count_hash
        posts = {}
        Post.all.each do |post|
            posts[post] = post.likes.count
        end
        posts
    end

    def self.ordered_by_likes
        posts = self.like_count_hash
        Hash[posts.sort_by{|k, v| v}.reverse]
    end

    def self.top_ten_posts
        posts = self.ordered_by_likes
        posts.first(10).to_h
    end

    def self.most_popular
        posts = self.ordered_by_likes
        posts.first
    end

    def self.least_popular
        posts = self.ordered_by_likes
        posts.reverse_each.first
    end

    def self.ordered_by_creation
        Post.all.reverse
    end

    def self.newest_ten_posts
        posts = self.ordered_by_creation
        posts.first(10)
    end
    
    def self.newest_post 
        posts = self.ordered_by_creation
        posts.first
    end 
end
