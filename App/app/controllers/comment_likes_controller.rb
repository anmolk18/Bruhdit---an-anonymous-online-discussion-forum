class CommentLikesController < ApplicationController
    before_action :find_comment
    before_action :find_comment_like, only: [:destroy]

    def create
        @post = Post.find(params[:post_id])
        if !already_liked?
            @comment.comment_likes.create(user_id: current_user.id)
            redirect_to post_path(@post)
        end
    end

    def destroy
        if already_liked?
          @comment_like.destroy
        end
        redirect_to post_path(@post)
    end


    private

    def find_comment
      @comment = Comment.find(params[:comment_id])
    end

    def already_liked?
        CommentLike.where(user_id: current_user.id, comment_id: params[:comment_id]).exists?
    end

    def find_comment_like
        @comment_like = @comment.comment_likes.find(params[:id])
    end
end
