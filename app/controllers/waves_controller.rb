class WavesController < ApplicationController
  before_filter :require_login, :only => [:create, :delete, :edit, :new, :update]

  def create
    @wave = current_user.waves.new(params[:wave])
    if @wave.save
      redirect_to user_waves_url(@wave.user.username)
    else
      render :new
    end
  end

  def destroy
    @wave = current_user.waves.find(params[:id])
    @wave.destroy
    redirect user_waves_url(@wave.user.username)
  end

  def edit
    @wave = current_user.waves.find(params[:id])
  end

  def index
    @waves = Wave.recent.all(:include => :user)
  end

  def new
    @wave = Wave.new
  end

  def show
    @wave = Wave.find(params[:id])
  end

  def update
    @wave = current_user.waves.find(params[:id])
    @wave.update_attributes(params[:wave])
    if @wave.save
      redirect_to user_waves_url(@wave.user.username)
    else
      render :edit
    end
  end
end
