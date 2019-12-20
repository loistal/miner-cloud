Rails.application.routes.draw do

	root 'sessions#index'

	post 'signup', to: 'users#create'

	get 'text', to: 'texts#index'

	post 'login', to: 'sessions#create'
	delete 'logout', to: 'sessions#destroy'

end
