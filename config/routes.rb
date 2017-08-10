AppProva::Application.routes.draw do

  root 'pages#home'
  get  'pages/home', to: 'pages#home'
end
