Rails.application.routes.draw do
  # mount ActionCable.server => '/cable' # We're not using this just yet
  root to: "application#home"

  get 'logs', to: "application#logs"
  get 'logs/:id', to: 'application#kiosk_log', as: 'log'
  get 'home', to: "application#home"
  get 'status', to: "application#status"
  get 'heartbeat', to: "application#heartbeat"
end
