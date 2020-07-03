class HomeController < ApplicationController

    layout 'base'
    before_action :remember_location

    def display
        @current_user = current_user
        @posts = Post.ordered_by_likes.keys
        @tags = Tag.all
        @top_ten_tags = Tag.tag_colors
        @new_post = Post.new
    end

    def analytics

        @current_user = current_user
        @top_ten_tags = Tag.tag_colors

        #User Analytics
        @user_count = User.all.count
        @top_ten_most_active = User.top_ten_users
        @top_ten_most_popular = User.top_ten_most_popular
        @top_ten_likers = User.top_ten_likers

        #Post Analytics
        @post_count = Post.all.count
        @top_ten_posts = Post.top_ten_posts
        @top_ten_most_commented_posts = Post.top_ten_most_commented

        #Comment Analytics
        @comment_count = Comment.all.count
        @top_ten_comments = Comment.top_ten_comments


    end
end
