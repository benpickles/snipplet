class UserWavesController < ApplicationController
  before_filter :load_user

  def index
    @waves = @user.waves.alphabetical.all(:include => :user)
  end

  def run
    @wave = @user.waves.find_by_command!(params[:command])
    redirect_to @wave.interpolate(params[:s])
  end

  private
    def load_user
      @user = User.find_by_username!(params[:username])
    end
end
