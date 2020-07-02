class HomeController < ApplicationController
    def display
        @current_user = current_user
        @posts = Post.all
        @tags = Tag.all
        @top_ten_tags = Tag.tag_colors
    end
end
