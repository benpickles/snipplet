class AccountsController < ApplicationController
  before_filter :require_login, :only => [:show, :update]
  before_filter :require_no_login, :only => [:create, :new]

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to user_waves_url(@user.username)
    else
      render :action => :new
    end
  end

  def show
    @user = current_user
  end

  def new
    @user = User.new
  end

  def update
    @user = current_user
    @user.attributes = params[:user]
    if @user.save
      redirect_to account_url
    else
      render :action => :show
    end
  end
end
