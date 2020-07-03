class Post < ApplicationRecord
    belongs_to :user
    has_many :post_tags
    has_many :tags, through: :post_tags
    has_many :comments, dependent: :destroy
    has_many :likes, dependent: :destroy

    validates :title, presence: true
    validates :body, presence: true
    accepts_nested_attributes_for :tags, allow_destroy: true, reject_if: :all_blank


    def summary
        self.body[0..1000] + "..."
    end
    #like-related post methods
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

    #time-related post methods
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

    #comment-related post methods
    def comment_like_count_hash
        comments = {}
        self.comments.each do |comment|
            comments[comment] = comment.comment_likes.count
        end
        comments
    end

    def comments_ordered_by_likes
        comments = self.comment_like_count_hash
        Hash[comments.sort_by{|k, v| v}.reverse]
    end

    def top_ten_post_comments
        comments = self.comments_ordered_by_likes
        comments.first(10).to_h
    end
    
    def top_three_post_comments
        comments = self.comments_ordered_by_likes
        comments.first(3).to_h
    end

    def comments_ordered_by_creation
        self.comments.reverse
    end

    def comments_to_display
        comments_ordered_by_creation.select{|comment| top_three_post_comments.include?(comment) == false}
    end

    def newest_ten_post_comments
        comments = self.comments_ordered_by_creation
        comments.first(10)
    end

    def comment_count
        self.comments.count
    end

    def self.comment_count_hash
        posts = {}
        Post.all.each do |post|
            posts[post] = post.comments.count
        end
        posts
    end

    def self.ordered_by_comments
        posts = self.comment_count_hash
        Hash[posts.sort_by{|k, v| v}.reverse]
    end

    def self.top_ten_most_commented
        posts = self.ordered_by_comments
        posts.first(10).to_h
    end

    def self.most_commented
        self.top_ten_most_commented.first
    end

    def self.least_commented
        self.top_ten_most_commented.reverse_each.first
    end

end
