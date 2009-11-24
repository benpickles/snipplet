class SnipsController < ApplicationController
  before_filter :require_login, :only => [:copy, :create, :delete, :edit, :new, :update]

  def copy
    original = Snip.find(params[:id])
    @snip = current_user.snips.new
    @snip.copy(original)
    if @snip.save
      redirect_to user_snips_url(current_user.username)
    else
      render :new
    end
  end

  def create
    @snip = current_user.snips.new(params[:snip])
    if @snip.save
      redirect_to user_snips_url(current_user.username)
    else
      render :new
    end
  end

  def destroy
    @snip = current_user.snips.find(params[:id])
    @snip.destroy
    redirect_to user_snips_url(current_user.username)
  end

  def edit
    @snip = current_user.snips.find(params[:id])
  end

  def index
    @snips = Snip.recent.all(:include => :user)
  end

  def new
    @snip = Snip.new(params.slice(:command, :note, :uri))
  end

  def show
    @snip = Snip.find(params[:id])

    respond_to do |format|
      format.txt {
        render :text => @snip.to_txt + "\n"
      }
    end
  end

  def update
    @snip = current_user.snips.find(params[:id])
    @snip.update_attributes(params[:snip])
    if @snip.save
      redirect_to user_snips_url(current_user.username)
    else
      render :edit
    end
  end
end
