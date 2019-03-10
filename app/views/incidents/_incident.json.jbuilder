json.extract! incident, :id, :identificator, :date_receive, :date_close, :state, :description, :source, :user_id, :current_state, :organisation_id, :docs, :created_at, :updated_at
json.url incident_url(incident, format: :json)
