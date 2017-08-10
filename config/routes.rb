AppProva::Application.routes.draw do

  devise_for :users
  root 'pages#home'
  get  'pages/home', to: 'pages#home'
end
