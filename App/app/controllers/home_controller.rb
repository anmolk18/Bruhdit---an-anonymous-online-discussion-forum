class HomeController < ApplicationController
    def display
        @current_user = current_user
        @posts = Post.all
    end
end
