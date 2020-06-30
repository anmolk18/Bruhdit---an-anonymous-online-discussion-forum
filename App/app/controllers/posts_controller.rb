class PostsController < ApplicationController
    before_action :current_post, only: [:show]
    def new
        @post = Post.new
    end

    def create
        @post = Post.new(post_params)
        if @post.valid?
            post.save
            redirect_to post_path(@post)
        else
            flash[:errors] = post.errors.full_messages
            redirect_to new_post_path
        end
    end

    def show
    end

    def edit
    end 

    def update 
        @post.update(post_params)
    end 

    private 
    
    def current_post 
        @post = Post.find(params[:id])
    end 

    def post_params
        params.require(:post).require(:user_id, :title, :body)
    end
end
