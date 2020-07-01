class CommentsController < ApplicationController
    before_action :current_comment, only: [:edit, :update, :destroy]
    before_action :allowed_user, only: [:edit, :update, :destroy]

    def new
        @comment = Comment.new
        @post_id = params[:post_id]
        @current_user_id = params[:user_id]
        @post = Post.find(params[:post_id])
        @comments = @post.comments
    end

    def create
        @comment = Comment.new(comment_params)
        validate(new_comment_path)
    end

    def edit
        @post_id = params[:post_id]
        @current_user_id = params[:user_id]
        @post = @comment.post
        @comments = @post.comments
    end

    def update
        @comment.update(comment_params)
        @comment.user == current_user
        validate(edit_comment_path)
    end

    def destroy
        @post = @comment.post
        @comment.destroy
        redirect_to post_path(@post)
    end

    private 

    def current_comment
        @comment = Comment.find(params[:id])
    end

    def comment_params
        params.require(:comment).permit(:body, :post_id, :user_id)
    end

    def validate(error_path)
        if @comment.valid?
            @comment.save
            redirect_to post_path(comment_params[:post_id])
        else 
            flash[:errors] = @comment.errors.full_messages
            redirect_to new_comment_path
        end
    end


    def allowed_user
        redirect_to comment_path(@comment) if current_user.id != @comment.user.id
    end
end
