Rails.application.routes.draw do
  #resources :cities
  #resources :states
  
  namespace :api do
    namespace :v1 do
      resources :cities
      resources :states
      
    end
end


end
