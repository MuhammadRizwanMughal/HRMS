class HomeController < ApplicationController
  before_action :check_current_user_callback
  before_action :authenticate_user!
  def index
  end

  def check_current_user_callback
    if current_user.present?
    	if current_user.admin == true
      	redirect_to admin_users_path
  		else
  			redirect_to user_path(current_user.id)
  		end
    end
  end
end
