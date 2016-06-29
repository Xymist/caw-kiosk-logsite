Rails.application.routes.draw do

  devise_for :users
  
  mount PostgresqlLoStreamer::Engine => "/logo_image"

  authenticate :user, lambda { |user| user.admin? } do
    mount Blazer::Engine, at: "database_admin"
  end

  root to: "application#home"

  get 'logs', to: "application#logs"
  get 'logs/:kiosk', to: 'application#kiosk_log', as: 'log'
  get 'home', to: "application#home"
  get 'status', to: "application#status"
  get 'feedback', to: "feedback#overview"
  get 'feedback/:kiosk', to: "feedback#kiosk"
  get 'heartbeat', to: "public_kiosk#heartbeat"
  get 'heartbeat/:kiosk', to: "public_kiosk#heartbeat"

  resources 'advice_pages'
  resources 'jurisdictions'
  resources 'kiosks'

  get  'public_kiosk/:kiosk', to: "public_kiosk#home"
  get  'public_kiosk/:kiosk/feedback', to: "public_kiosk#feedback", as: "form_responses"
  post 'public_kiosk/:kiosk/feedback', to: "public_kiosk#create_feedback"
  get  'public_kiosk/:kiosk/:topic', to: "public_kiosk#advice_topic"
  get  "public_kiosk" => redirect("public_kiosk/waverley")
  get  "public_kiosk/:kiosk/:topic/:exit_url_id", to: "public_kiosk#exit_site"

end
