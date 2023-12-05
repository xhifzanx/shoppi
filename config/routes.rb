Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :products
  resources :product_configurations do 
    collection do 
      post :generate_category
    end
  end
end
