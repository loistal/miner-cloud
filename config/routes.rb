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
	post 'reschedule_again', to: 'cards#reschedule_again'
	post 'mastered', to: 'cards#set_mastered'
	post 'delete_card', to: 'cards#delete_card'

	post 'delete-last-card', to: 'cards#delete_last_card'

end
