class Comment < ApplicationRecord
    belongs_to :post
    belongs_to :user
    validates :body, presence: :true
    has_many :comment_likes, dependent: :destroy

    def self.like_count_hash
        comments = {}
        Comment.all.each do |comment|
            comments[comment] = comment.comment_likes.count
        end
        comments
    end

    def self.ordered_by_likes
        comments = self.like_count_hash
        Hash[comments.sort_by{|k, v| v}.reverse]
    end

    def self.top_ten_comments
        comments = self.ordered_by_likes
        comments.first(10).to_h
    end

    def self.most_popular
        comments = self.ordered_by_likes
        comments.first
    end

    def self.least_popular
        comments = self.ordered_by_likes
        comments.reverse_each.first
    end

    def self.ordered_by_creation
        Comment.all.reverse
    end

    def self.newest_ten_comments
        comments = self.ordered_by_creation
        comments.first(10)
    end
    
    def self.newest_comment
        comments = self.ordered_by_creation
        comments.first
    end 

    #most commented post
end
