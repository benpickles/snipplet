class ApplicationController < ActionController::Base
  helper :all
  helper_method :current_user

  protect_from_forgery

  filter_parameter_logging :password

  private
    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.record
    end

    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end

    def require_login
      redirect_to login_url if current_user.nil?
    end

    def require_no_login
      redirect_to root_url if current_user
    end
end
