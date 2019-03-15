class Admin::UsersController < ApplicationController
  def index
		@users = User.all
	end

	def show
  	@user = User.find_by_id(params[:id])
    if @user.admin == true
      redirect_to admin_users_path
    end
    @leave = @user.leaves
  end

  def destroy
  		@user = User.find_by_id(params[:id])
  		@user.destroy
  		redirect_to admin_users_path
  end

  def check_admin_presence
    if current_user.present?
      redirect_to admin_users_path
    end
  end
end
