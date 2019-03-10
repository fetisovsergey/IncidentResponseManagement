json.extract! event, :id, :incident_id, :description, :date_event, :user_id, :created_at, :updated_at
json.url event_url(event, format: :json)
