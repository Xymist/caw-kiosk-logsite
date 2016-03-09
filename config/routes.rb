Rails.application.routes.draw do
  get 'home/index'

  # mount ActionCable.server => '/cable' # We're not using this just yet
  root to: "home#index"

end
