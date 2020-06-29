class HomeController < ApplicationController
    def display
        @current_user = current_user
    end
end
