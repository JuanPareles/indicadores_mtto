Rails.application.routes.draw do
  resources :mantenimientos
  resources :equipos

  get 'menu/borrar_todo'
  get 'menu/index'
  get 'menu/base_datos'
  get 'menu/indicadores_seleccion'
  post 'menu/indicadores_post'
  get 'menu/indicadores_resultados'
  root :to => 'menu#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
