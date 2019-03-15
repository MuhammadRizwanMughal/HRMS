class ApplicationController < ActionController::Base
	def after_sign_in_path_for(resource)
    if resource.admin == true
    	admin_users_path
    else
    	user_path(resource)
    end
  end
end
