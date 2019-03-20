class User < ApplicationRecord
	# has_one_attached :avatar
	has_many :leaves
	has_one :user_leave_distribution
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
