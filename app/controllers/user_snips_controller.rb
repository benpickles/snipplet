class UserSnipsController < ApplicationController
  before_filter :load_user

  def index
    respond_to do |format|
      format.html {
        @snips = @user.snips.alphabetical.all(:include => :user)
      }
      format.atom {
        @snips = @user.snips.recent
      }
    end
  end

  def run
    @snip = @user.snips.find_by_command!(params[:command])
    redirect_to @snip.interpolate(params.slice(:l, :q, :s))
  end

  private
    def load_user
      @user = User.find_by_username!(params[:username])
    end
end
