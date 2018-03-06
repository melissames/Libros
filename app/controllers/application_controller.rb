class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception



  private

    def get_session
      if session[:current_user_id]
        session[:current_user_id]
      else
        flash[:message] = "You must be logged in to access this page"
        redirect_to login_path
      end
    end

    def require_login
      flash[:message] = "You must be logged in to access this page"
      redirect_to login_path unless session.include? :current_user_id
    end
end
