class HomeController < ApplicationController
    layout 'base'
    def display
        @current_user = current_user
        @posts = Post.ordered_by_likes.keys
        @tags = Tag.all
        @top_ten_tags = Tag.tag_colors
        @new_post = Post.new
    end
end
