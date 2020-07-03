class TagsController < ApplicationController
    layout 'base'
    def index 
        @current_user = current_user
        @tags = Tag.ordered_by_count.keys
        @top_ten_tags = Tag.tag_colors
    end 

    def show
        @current_user = current_user
        @tag = Tag.find(params[:id])
        @posts = @tag.posts
        @top_ten_tags = Tag.tag_colors
    end


end
