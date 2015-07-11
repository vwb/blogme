Rails.application.routes.draw do
    

  mount Ckeditor::Engine => '/ckeditor'
    devise_for :users

    authenticated :user do
		root to: "blogs#index", :as => "authenticated-root"
	end

	root to: "home#home"

    get 'blogs/index_all', to: 'blogs#index_all'

    resources :blogs

    resources :posts do
        resources :comments
    end

    get "search", to: "search#search"

end
