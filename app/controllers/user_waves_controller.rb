class UserWavesController < ApplicationController
  before_filter :load_user

  def index
    respond_to do |format|
      format.html {
        @waves = @user.waves.alphabetical.all(:include => :user)
      }
      format.atom {
        @waves = @user.waves.recent
      }
    end
  end

  def run
    @wave = @user.waves.find_by_command!(params[:command])
    redirect_to @wave.interpolate(params[:q], params[:l], params[:s])
  end

  private
    def load_user
      @user = User.find_by_username!(params[:username])
    end
end
