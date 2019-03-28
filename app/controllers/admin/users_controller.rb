class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  def index
		@users = User.all
	end

	def show
  	@user = User.find_by_id(params[:id])
    if @user.admin == true
      redirect_to admin_users_path
    end

    respond_to do |format|
      format.html
      format.pdf do 
        pdf = UserDetailPdf.new(@user)
        send_data pdf.render, filename: "#{@user.fname+' '+@user.lname}'s details.pdf",
                              type: "application/pdf",
                              disposition: "inline"
      end
    end 
  end

  def destroy
  		@user = User.find_by_id(params[:id])
      @user.destroy
  		redirect_to admin_users_path
  end
end
