Rails.application.routes.draw do
  devise_for :users

  root to: "application#home"

  get 'logs', to: "application#logs"
  get 'logs/:id', to: 'application#kiosk_log', as: 'log'
  get 'home', to: "application#home"
  get 'status', to: "application#status"
  get 'heartbeat', to: "application#heartbeat"

  resources 'advice_pages'

  get 'public_kiosk/:kiosk', to: "public_kiosk#home"
  get 'public_kiosk/:kiosk/:topic', to: "public_kiosk#advice_topic"
  get "public_kiosk" => redirect("public_kiosk/waverley")

end
