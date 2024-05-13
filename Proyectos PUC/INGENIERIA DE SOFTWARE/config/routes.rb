Rails.application.routes.draw do
    get 'rooms/index'
    devise_for :admins, path: 'admin', controllers: { sessions: 'devise/sessions'}
    root 'pages#home'
    devise_for :usuarios, controllers: { registrations: "usuarios/registrations" }
    get 'index', to: 'pagina_inicial#index'
    post '/products', to: 'products#create'
    resources :products do
        resources :califications, only: [:new, :create]
      collection do
          get 'filter'
      end
      member do
          get 'vendedor_profile'
        get 'productos_vendedor'
      end
    end
    resources :rooms do
        resource :messages
    end
    get '/filter', to: 'products#filter', as: 'filter_products_custom'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Rutas de admin
    get '/admin', to: 'admin/admin#home', as: :admin_root # panel de admin
    get '/admin/usuarios', to: 'admin/usuarios#index', as: :admin_usuarios
    patch '/admin/usuarios/:id/ban', to: 'admin/usuarios#ban', as: :ban_admin_usuario
    patch '/admin/usuarios/:id/unban', to: 'admin/usuarios#unban', as: :unban_admin_usuario
    delete '/admin/usuarios/:id', to: 'admin/usuarios#destroy', as: :destroy_admin_usuario
    get 'admin/usuarios/:id/products', to: 'admin/usuarios#index_usuario_products', as: :admin_usuario_products
    get 'admin/usuarios/:id/califications', to: 'admin/usuarios#index_usuario_califications',
as: :admin_usuario_califications
    get 'admin/products', to: 'admin/products#index', as: :admin_products
    delete 'admin/products/:id', to: 'admin/products#destroy_product', as: :destroy_admin_product
    delete 'admin/califications/:id', to: 'admin/califications#destroy_calification', as: :destroy_admin_calification

  # Rutas solicitud
    get 'solicitud/new/:id', to: 'solicitud#new', as: :new_solicitud
    post 'solicitud/create', to: 'solicitud#create', as: :create_solicitud
    get 'solicitudes', to: 'solicitud#index', as: :solicitudes
    patch 'solicitud/:id/accept', to: 'solicitud#accept', as: :accept_solicitud
    patch 'solicitud/:id/reject', to: 'solicitud#reject', as: :reject_solicitud

    resources :califications, only: [:new, :create]
end
