class UsersController < ApplicationController
	before_action :check_current_user_callback, :only => [:index]
	before_action :authenticate_user!
  def index
  end

  def show
  	@user = User.find_by_id(params[:id])
  	@leaves = @user.leaves
  	@leave = @user.leaves.find_by_id(:id)
  end

  def check_current_user_callback
    if user_signed_in?
      redirect_to user_path(current_user.id)
    else
    	redirect_to root_path
    end
  end
end
