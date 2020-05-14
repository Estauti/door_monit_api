Rails.application.routes.draw do
  scope :api do
    mount ActionCable.server => '/cable'

    devise_for :users,
      path: 'auth',
      controllers: {
        sessions: 'sessions',
        registrations: 'registrations'
      }, 
      defaults: { format: :json }

    get 'auth/refresh', :to => 'users#refresh'
    get 'auth/get_by_token', :to => 'users#get_by_token'

    resources :devices
    resources :measurements
    resources :alerts
  end

  match "/*path", to: redirect(path: "/?redirect=%{path}"), constraints: lambda { |params, request| !params[:path].match(/api|rails/) }, via: :all
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
