class UserDetailPdf < Prawn::Document
	require 'prawn/table'
	def initialize(user)
		super()
		@user = user
		header
		user_image
		user_name
		user_details
	end

	def header
		move_down 50
	end
	def user_image
		avatar = @user.avatar
		image "#{Rails.root}/app/assets/images/messi.jpg", :width => 150, :height => 150 
		move_down 10
	end

	def user_name
		text "#{@user.fname} #{@user.lname}", size: 25, style: :bold, :color => 'FF0000'
	end

	def user_details
		move_down 10
		table user_details_items do 
			column(0).font_style = :bold
			column(1..2).align = :right
			self.row_colors = ['DDDDDD', 'FFFFFF']
		end
	end

	def user_details_items
		 [['Firstname',@user.fname],
		  ['Lastname',@user.lname],
		  ['Username',@user.uname],
		  ['Email', @user.email], 
		  ['Mobile', @user.mobile], 
		  ['Address', @user.address], 
		  ['Date of Birth', @user.dob], 
		  ['Gender', @user.gender] ] 	
	end
end