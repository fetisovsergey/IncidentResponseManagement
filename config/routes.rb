Rails.application.routes.draw do
  resources :infected_machines
  devise_for :users
  resources :users, except: [:new]
  resources :remote_control_centers
  resources :botnets
  resources :departures
  resources :documents
  resources :organisations
  resources :relationships
  resources :incidents, except: [:index, :destroy]
  resources :events, except: [:index, :show, :new]

  root to: "static_pages#home"

  # Show open incidents
  match '/active_incidents', to: 'incidents#active_incidents', via: :get, as: :active_incidents

  # Show closed incidents
  match '/closed_incidents', to: 'incidents#closed_incidents', via: :get, as: :closed_incidents

  # Open/Close Incident
  match '/incidents/:id/close', to: 'incidents#close', via: :get, as: :close_incident
  match '/incidents/:id/open', to: 'incidents#open', via: :get, as: :open_incident

  # Show statistic
  match '/statistic', to: 'static_pages#statistic', via: :get, as: :statistic

  # Show analytics
  match '/analytics', to: 'static_pages#analytics', via: :get, as: :analytics

  # Show incident analytics
  match '/incident_analytics', to: 'static_pages#incident_analytics', via: :get, as: :incident_analytics

  # Export DB Json
  match '/export_db_json', to: 'static_pages#export_db_json', via: :get, as: :export_json

  # Export DB seeds
  match '/export_db_seed', to: 'static_pages#export_db_seeds', via: :get, as: :export_seeds

  # render 404
  get '*unmatched_route', :to => 'application#render_404'
end
