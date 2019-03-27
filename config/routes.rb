Rails.application.routes.draw do
  get 'leaves/index'
	root to: 'home#index'

  devise_for :users, controllers: {
    sessions: 'users/sessions', registrations: 'users/registrations'
  }
	
	namespace :admin do
  	resources :users, only: [:index, :show, :destroy] do
  		resources :leaves do
  			get 'user_leave_approval_decision'
  		end
		end
	end

	resources :users, only: [:index, :show] do
		resources :leaves
	end

	resources :notifications do
		get 'clear_notifications'
	end
end
