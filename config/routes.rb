Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :requeriments

  # Importação dos dados brutos do Protocolo do requerimento GET que foi ultilizado
  # o método 'POST' ao invés do método 'GET' para enviar mais dados.
  post 'import', to: 'requeriments#new'
end
