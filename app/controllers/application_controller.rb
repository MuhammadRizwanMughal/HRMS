class ApplicationController < ActionController::Base
	before_action :authenticate_user!
	skip_before_action :verify_authenticity_token
	def after_sign_in_path_for(resource)
    if resource.admin == true
    	admin_users_path
    else
    	user_path(resource)
    end
  end
end
