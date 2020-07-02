class User < ApplicationRecord
    has_many :posts
    has_many :likes, dependent: :destroy
    has_many :comment_likes, dependent: :destroy
    has_many :comments
    has_secure_password
    # has_many :comments
    # has_many :likes
    # has_many :tags, through: :posts
    # has_many :messages
    validates :user_name, uniqueness: true
    validates :user_name, format: { with: /[a-zA-Z0-9_]+/ }
    validates :user_name, length: {minimum: 3, maximum: 30}
    
    def chatting_users
        convos = Conversation.where("sender_id = ? | recipient_id = ?", self.id, self.id)
        convos.map{|c| 
            c.sender_id == self.id ? User.find(recipient_id) : User.find(sender_id)
        }
    end
    def self.post_count_hash
        users = {}
        User.all.each do |user|
            users[user] = user.posts.count
        end
        users
    end

    def self.ordered_by_posts
        users = self.post_count_hash
        Hash[users.sort_by{|k, v| v}.reverse]
    end

    def self.top_ten_users
        users = self.ordered_by_posts
        users.first(10).to_h
    end

    def self.most_active
        users = self.ordered_by_posts
        users.first
    end

    def post_likes_received
        likes = 0
        self.posts.each do |post|
            likes += post.likes.count
        end
        likes        
    end

    def comment_likes_received
        likes = 0
        self.comments.each do |comment|
            likes += comment.comment_likes.count
        end
        likes
    end

    def all_likes_received
        self.post_likes_received + self.comment_likes_received
    end

    def self.likes_received_hash
        users = {}
        User.all.each do |user|
            users[user] = user.all_likes_received
        end
        users
    end

    def self.ordered_by_likes_received
        users = self.likes_received_hash
        Hash[users.sort_by{|k, v| v}.reverse]
    end

    def self.top_ten_most_popular
        users = self.ordered_by_likes_received
        users.first(10).to_h
    end

    def self.most_popular
        users = self.ordered_by_likes_received
        users.first
    end

    def post_likes_given
        self.likes.count      
    end

    def comment_likes_given
        self.comment_likes.count
    end

    def all_likes_given
        self.post_likes_given + self.comment_likes_given
    end

    def self.likes_given_hash
        users = {}
        User.all.each do |user|
            users[user] = user.all_likes_given
        end
        users
    end

    def self.ordered_by_likes_given
        users = self.likes_given_hash
        Hash[users.sort_by{|k, v| v}.reverse]
    end

    def self.top_ten_likers
        users = self.ordered_by_likes_given
        users.first(10).to_h
    end

    def self.biggest_liker
        users = self.ordered_by_likes_given
        users.first
    end



end
