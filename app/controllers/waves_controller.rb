class WavesController < ApplicationController
  before_filter :require_login, :only => [:copy, :create, :delete, :edit, :new, :update]

  def copy
    original = Wave.find(params[:id])
    @wave = current_user.waves.new
    @wave.copy(original)
    if @wave.save
      redirect_to user_waves_url(current_user.username)
    else
      render :new
    end
  end

  def create
    @wave = current_user.waves.new(params[:wave])
    if @wave.save
      redirect_to user_waves_url(current_user.username)
    else
      render :new
    end
  end

  def destroy
    @wave = current_user.waves.find(params[:id])
    @wave.destroy
    redirect_to user_waves_url(current_user.username)
  end

  def edit
    @wave = current_user.waves.find(params[:id])
  end

  def index
    @waves = Wave.recent.all(:include => :user)
  end

  def new
    @wave = Wave.new(params.slice(:command, :note, :uri))
  end

  def show
    @wave = Wave.find(params[:id])

    respond_to do |format|
      format.txt {
        render :text => @wave.to_txt + "\n"
      }
    end
  end

  def update
    @wave = current_user.waves.find(params[:id])
    @wave.update_attributes(params[:wave])
    if @wave.save
      redirect_to user_waves_url(current_user.username)
    else
      render :edit
    end
  end
end
