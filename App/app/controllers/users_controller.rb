class UsersController < ApplicationController
    skip_before_action :authorized, only: [:new, :create]
    #Sign Up for a user.
    def new
        @user = User.new()
    end

    def create
        user = User.new(user_params)
        if user.valid?
            user.save()
            session[:user_id] = user.id
            redirect_to '/home'
        else
            flash[:errors] = user.errors.full_messages
            redirect_to new_user_path
        end
    end

    
    def show
        @user = current_user
    end

    #Delete an account
    def destroy
        current_user.destroy
        redirect_to '/'
    end

    private

    def user_params 
        params.require(:user).permit(:user_name, :password, :password_confirmation)
    end
end
