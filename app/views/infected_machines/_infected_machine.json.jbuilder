json.extract! infected_machine, :id, :incident_id, :mac, :name, :ip, :botnet_id, :organisation_id, :created_at, :updated_at
json.url infected_machine_url(infected_machine, format: :json)
