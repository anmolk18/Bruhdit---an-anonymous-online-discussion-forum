class SessionsController < ApplicationController
    skip_before_action :authorized, only: [:new, :create, :welcome]
    skip_before_action :verify_authenticity_token
    before_action :redirect_to_home, only: [:welcome, :new]

    def welcome
    end

    def new
    end
    
    def create
        @user = User.find_by(user_name: params[:user_name])
    
        if @user && @user.authenticate(params[:password])
          session[:user_id] = @user.id
          redirect_to '/home'
        else
          flash[:errors] ||= [] 
          flash[:errors] << "Username or Password Invalid"
          redirect_to '/login'
        end
    end


    def destroy
        session.destroy
        redirect_to '/'
    end
  
    private

    def redirect_to_home
      redirect_to '/home' if logged_in?
    end
end