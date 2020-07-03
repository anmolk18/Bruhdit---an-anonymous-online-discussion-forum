class ApplicationController < ActionController::Base
    before_action :authorized
    helper_method :current_user
    helper_method :logged_in?
    helper_method :back
    helper_method :remember_location

    def current_user
      User.find_by(id: session[:user_id])
    end

    def logged_in?
      !current_user.nil?
    end

    def authorized
        redirect_to '/' if !logged_in? 
    end
    
    def back
      redirect_to  session[:return_to]
    end

    def remember_location
      session[:return_to] = request.referer
    end

end
