class PostsController < ApplicationController
    before_action :current_post, only: [:show, :edit, :update, :destroy]
    def new
        @post = Post.new
        @tags = Tag.all
    end

    def create
        @post = Post.new(post_params)
        @post.user_id = current_user.id
        validate(new_post_path)
    end

    def show
        @current_user = current_user
    end

    def edit
        @tags = Tag.all
    end 

    def update 
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
end
