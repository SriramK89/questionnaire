Rails.application.routes.draw do
  post 'data/upload_csv'
  get 'data/display'
  root to: 'data#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
