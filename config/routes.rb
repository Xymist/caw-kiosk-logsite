Rails.application.routes.draw do
  # mount ActionCable.server => '/cable' # We're not using this just yet
  root to: "home#index"

end
