Rails.application.routes.draw do
    
    mount Ckeditor::Engine => '/ckeditor'

    #Set up devise routes for Users
    devise_for :users

    #If user is signed in set specific homepage
    authenticated :user do
		root to: "users#home", :as => "authenticated-root"
	end

    #standard root
	root to: "home#home"

    #index of all the blogs, used for development
    get 'blogs/index_all', to: 'blogs#index_all'


    get 'users/discover', to: 'users#discover'
    get "users/home", to: "users#home"


    resources :users do
        member do
            get :following
        end
    end

    resources :posts do
        resources :comments
    end

    get "search", to: "search#search"


    resources :relationships, only: [:create, :destroy]

    resources :blogs do
        member do
            get :followers
        end
    end
    

end
