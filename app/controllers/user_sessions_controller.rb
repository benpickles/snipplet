class UserSessionsController < ApplicationController
  def create
    @user_session = UserSession.new(params[:user_session])
    @user_session.save do |result|
      if result
        redirect_to user_waves_url(current_user.username)
      else
        render :action => 'new'
      end
    end
  end

  def destroy
    current_user_session.destroy
    redirect_to root_url
  end

  def new
    @user_session = UserSession.new
  end
end
