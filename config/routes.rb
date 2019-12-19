Rails.application.routes.draw do

	root 'sessions#index'

	post 'signup', to: 'users#create'

end
