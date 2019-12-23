Rails.application.routes.draw do

	resources :articles
	
	root 'sessions#index'

	post 'signup', to: 'users#create'

	get 'text', to: 'texts#index'

	post 'login', to: 'sessions#create'
	delete 'logout', to: 'sessions#destroy'

	post 'upload', to: 'articles#create'

	post 'filter', to: 'texts#index'

	get 'card', to: 'cards#index'

	post 'createcard', to: 'cards#create'

	post 'reschedule_good', to: 'cards#reschedule_good'
end
