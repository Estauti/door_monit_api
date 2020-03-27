Rails.application.routes.draw do
  scope :api do
    resources :devices
    resources :measurements
  end

  match "/*path", to: redirect(path: "/?redirect=%{path}"), constraints: lambda { |params, request| !params[:path].match(/api|rails/) }, via: :all
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
