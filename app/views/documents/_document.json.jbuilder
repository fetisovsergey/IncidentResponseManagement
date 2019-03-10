json.extract! document, :id, :incident_id, :date_signature, :number, :user_id, :source, :description, :created_at, :updated_at
json.url document_url(document, format: :json)
