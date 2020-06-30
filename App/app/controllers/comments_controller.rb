class CommentsController < ApplicationController
    before_action :current_comment, only: [:edit, :update, :destroy]

    def new
        @comment = Comment.new
        @post_id = params[:post_id]
        @current_user_id = params[:user_id]
    end

    def create
        @comment = Comment.new(comment_params)
        if @comment.valid?
            @comment.save
            redirect_to post_path(comment_params[:post_id])
        else 
            flash[:errors] = @comment.errors.full_messages
            redirect_to new_comment_path
        end
    end

    def edit
    end

    def update
        @comment.update(comment_params)
        @comment.user == User.first
    end

    def destroy
        @comment.destroy
    end

    private 

    def current_comment
        @comment = Comment.find(params[:id])
    end

    def comment_params
        params.require(:comment).permit(:body, :post_id, :user_id)
        #:user_id, :post_id, 
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
end
