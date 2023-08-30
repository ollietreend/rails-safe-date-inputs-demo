Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  mount GovukPublishingComponents::Engine, at: "/component-guide" if Rails.env.development?
end
