Rails.application.routes.draw do
  get 'kiosk_admin/defaults'

  devise_for :users
  mount PostgresqlLoStreamer::Engine => "/logo_image"

  root to: "application#home"

  get 'logs', to: "application#logs"
  get 'logs/:kiosk', to: 'application#kiosk_log', as: 'log'
  get 'home', to: "application#home"
  get 'status', to: "application#status"
  get 'heartbeat', to: "public_kiosk#heartbeat"

  resources 'advice_pages'
  resources 'kiosk_admin'

  get 'public_kiosk/:kiosk', to: "public_kiosk#home"
  get 'public_kiosk/:kiosk/:topic', to: "public_kiosk#advice_topic"
  get "public_kiosk" => redirect("public_kiosk/waverley")
  get "public_kiosk/:kiosk/:topic/:exit_url_id", to: "public_kiosk#exit_site"

end
