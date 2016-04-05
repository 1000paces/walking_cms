Rails.application.routes.draw do
	resource :user_session, only: [:create, :new, :destroy]  
	
	namespace :admin do
		resources :sites, only: [:show]
		get "home" => "sites#show", :as => :home

		resources :domains
		resources :headers
		match "headers/:id/edit(/:type)" => "headers#edit", :as => "edit_headers", :via => [:get]

		resources :users    
		resources :pages 
		match "pages/sort" => "pages#sort", :as => "page_list_sort", :via => [:get, :post]
		match "pages/:id/duplicate" => "pages#duplicate", :as => "duplicate_page", :via => [:get]
		match "page/restore" => "pages#restore", :as => "page_restore", :via => [:post]

		#match "pages/:id/crop" => "pages#crop", :as => "crop_page", :via => [:post, :patch]
		resources :rows, only: [:create, :sort]
		match "rows/:page_id/sort" => "rows#sort", :as => "rows_sort", :via => [:get, :post]
		resources :cells, :except => [:edit]
		match "cells/:id/edit(/:type)" => "cells#edit", :as => "edit_cell", :via => [:get]
		match "cells/:row_id/sort" => "cells#sort", :as => "cells_sort", :via => [:get, :post]
		match "cell/restore" => "cells#restore", :as => "cell_restore", :via => [:post]
		match "cell/:id/duplicate" => "cells#duplicate", :as => "duplicate_cell", :via => [:post]

		resources :settings
		resources :assets
		resources :help, :only => [:index, :show]
		resources :images, only: [:index, :new, :create, :destroy]
 end

	#get 'welcome/index'
	#get '/' => "tour#index"
	resources :tour, only: [:index]
	get '/(:id)' => "index#show", :as => :public

	get "login" => "user_sessions#new", :as => :login
	


	# The priority is based upon order of creation: first created -> highest priority.
	# See how all your routes lay out with "rake routes".

	# You can have the root of your site routed with "root"
	# root 'welcome#index'

	# Example of regular route:
	#   get 'products/:id' => 'catalog#view'

	# Example of named route that can be invoked with purchase_url(id: product.id)
	#   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

	# Example resource route (maps HTTP verbs to controller actions automatically):
	#   resources :products

	# Example resource route with options:
	#   resources :products do
	#     member do
	#       get 'short'
	#       post 'toggle'
	#     end
	#
	#     collection do
	#       get 'sold'
	#     end
	#   end

	# Example resource route with sub-resources:
	#   resources :products do
	#     resources :comments, :sales
	#     resource :seller
	#   end

	# Example resource route with more complex sub-resources:
	#   resources :products do
	#     resources :comments
	#     resources :sales do
	#       get 'recent', on: :collection
	#     end
	#   end

	# Example resource route with concerns:
	#   concern :toggleable do
	#     post 'toggle'
	#   end
	#   resources :posts, concerns: :toggleable
	#   resources :photos, concerns: :toggleable

	# Example resource route within a namespace:
	#   namespace :admin do
	#     # Directs /admin/products/* to Admin::ProductsController
	#     # (app/controllers/admin/products_controller.rb)
	#     resources :products
	#   end

	#root :to => 'tour#index'
	root :to => 'index#show'
end
