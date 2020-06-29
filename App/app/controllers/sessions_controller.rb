class SessionsController < ApplicationController
    skip_before_action :authorized, only: [:new, :create, :welcome]

    def welcome
      redirect_to '/home' if logged_in?
    end

    def new
    end
    
    def create
        @user = User.find_by(user_name: params[:user_name])
    
        if @user && @user.authenticate(params[:password])
          session[:user_id] = @user.id
          redirect_to '/home'
        else
          flash[:errors] = "Username or Password Invalid"
          redirect_to '/login'
        end
    end


    def destroy
        session.destroy
        redirect_to '/'
    end
  
end