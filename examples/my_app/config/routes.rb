Rails.application.routes.draw do
  get 'welcome/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'welcome#index'

  get '/session/callback', to: 'session#callback', as: 'callback'
  get '/session/terminate', to: 'session#terminate', as: 'sign_out'
end
