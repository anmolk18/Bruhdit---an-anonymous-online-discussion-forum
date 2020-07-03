class PostsController < ApplicationController
    before_action :current_post, only: [:show, :edit, :update, :destroy]
    before_action :allowed_user, only: [:edit, :update, :destroy]
    layout 'base'
    def index
        @current_user = current_user
        @posts = Post.ordered_by_creation
        @tags = Tag.all
        @top_ten_tags = Tag.tag_colors
        @new_post = Post.new
    end
    
    def new
        @post = Post.new
        @tags = Tag.all
        @user = current_user
    end

    def create
        @post = Post.new(post_params)
        @post.user_id = current_user.id
        validate(home_path)
    end

    def show
        @current_user = current_user
        @comments = @post.comments_to_display
        @top_three_comments = @post.top_three_post_comments.keys
        @top_ten_tags = Tag.tag_colors
        @new_comment = Comment.new()
    end

    def edit
        @tags = Tag.all
        @post = current_post
        @current_user = current_user
        @top_ten_tags = Tag.tag_colors
        @top_three_comments = @post.top_three_post_comments.keys
        @comments = @post.comments_to_display
    end 

    def update 
        @current_user = current_user
        @post.update(post_params)
        validate(edit_post_path)
    end 

    def destroy 
        @post.destroy
        redirect_to '/home'
    end
    
    private

    def current_post
        @post = Post.find(params[:id])
    end

    def post_params
        params.require(:post).permit(:user_id, :title, :body, tag_ids: [], tags_attributes: [:name])
    end

    def validate(error_path)
        if @post.valid?
            @post.save
            redirect_to post_path(@post)
        else
            flash[:errors] = @post.errors.full_messages
            redirect_to error_path
        end
    end

    def allowed_user
        redirect_to post_path(@post) if current_user.id != @post.user.id
    end
end