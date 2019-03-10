# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

namespace :db do
	desc "Create test objects"
	task :create_objects => :environment do
		i = 0
		#Generate Users
		#while i < 10 do
		  User.create(name: "Иванов И.И.", email: "ivanov-ii", password: "123456", password_confirmation: "123456")
		#  i = i + 1
		#end


		i = 0

		## Generate organisations

		while i < 30 do
		  organisation = Organisation.create(name: "Organisation_#{Random.rand(11000)}", address: SecureRandom.urlsafe_base64(9), contact_tech: Random.rand(11000), contact_security: Random.rand(11000), ip: Random.rand(11000), region: "РЦМ", handler: SecureRandom.urlsafe_base64(9), description: SecureRandom.urlsafe_base64(20))
		  user = User.find(User.pluck(:id).shuffle.first)
		  month = Random.rand(11)
		  Incident.create(date_receive: "2017-#{month}-09", date_incident: "2017-#{month}-08", date_close: "2017-#{month}-15", state: "closed", description: SecureRandom.urlsafe_base64(20), source: "СООР", current_state: SecureRandom.urlsafe_base64(20), docs: SecureRandom.urlsafe_base64(10), organisation_id: organisation.id, user_id: user.id)
		  Incident.create(date_receive: "2017-#{month}-09", date_incident: "2017-#{month}-08", date_close: "2017-#{month}-15", state: "closed", description: SecureRandom.urlsafe_base64(20), source: "СООР", current_state: SecureRandom.urlsafe_base64(20), docs: SecureRandom.urlsafe_base64(10), organisation_id: organisation.id, user_id: user.id)
		  Incident.create(date_receive: "2017-#{month}-09", date_incident: "2017-#{month}-08", date_close: "2017-#{month}-15", state: "closed", description: SecureRandom.urlsafe_base64(20), source: "СООР", current_state: SecureRandom.urlsafe_base64(20), docs: SecureRandom.urlsafe_base64(10), organisation_id: organisation.id, user_id: user.id)
		  Incident.create(date_receive: "2017-#{month}-09", date_incident: "2017-#{month}-08", date_close: "2017-#{month}-15", state: "closed", description: SecureRandom.urlsafe_base64(20), source: "СООР", current_state: SecureRandom.urlsafe_base64(20), docs: SecureRandom.urlsafe_base64(10), organisation_id: organisation.id, user_id: user.id)

		  Incident.create(date_receive: "2017-#{month}-09", date_incident: "2017-#{month}-01", date_close: nil, state: "active", description: SecureRandom.urlsafe_base64(20), source: "СООР", current_state: SecureRandom.urlsafe_base64(20), docs: SecureRandom.urlsafe_base64(10), organisation_id: organisation.id, user_id: user.id)


		  organisation = Organisation.create(name: "Organisation_#{Random.rand(11000)}", address: SecureRandom.urlsafe_base64(9), contact_tech: Random.rand(11000), contact_security: Random.rand(11000), ip: Random.rand(11000), region: "ЦФО", handler: SecureRandom.urlsafe_base64(9), description: SecureRandom.urlsafe_base64(20))

		  Incident.create(date_receive: "2017-#{month}-09", date_incident: "2017-#{month}-08", date_close: "2017-#{month}-15", state: "closed", description: SecureRandom.urlsafe_base64(20), source: "СООР", current_state: SecureRandom.urlsafe_base64(20), docs: SecureRandom.urlsafe_base64(10), organisation_id: organisation.id, user_id: user.id)
		  Incident.create(date_receive: "2017-#{month}-09", date_incident: "2017-#{month}-08", date_close: "2017-#{month}-15", state: "closed", description: SecureRandom.urlsafe_base64(20), source: "СООР", current_state: SecureRandom.urlsafe_base64(20), docs: SecureRandom.urlsafe_base64(10), organisation_id: organisation.id, user_id: user.id)
		  Incident.create(date_receive: "2017-#{month}-09", date_incident: "2017-#{month}-08", date_close: "2017-#{month}-15", state: "closed", description: SecureRandom.urlsafe_base64(20), source: "СООР", current_state: SecureRandom.urlsafe_base64(20), docs: SecureRandom.urlsafe_base64(10), organisation_id: organisation.id, user_id: user.id)
		  Incident.create(date_receive: "2017-#{month}-09", date_incident: "2017-#{month}-08", date_close: "2017-#{month}-15", state: "closed", description: SecureRandom.urlsafe_base64(20), source: "СООР", current_state: SecureRandom.urlsafe_base64(20), docs: SecureRandom.urlsafe_base64(10), organisation_id: organisation.id, user_id: user.id)

		  Incident.create(date_receive: "2017-#{month}-09", date_incident: "2017-#{month}-01", date_close: nil, state: "active", description: SecureRandom.urlsafe_base64(20), source: "СООР", current_state: SecureRandom.urlsafe_base64(20), docs: SecureRandom.urlsafe_base64(10), organisation_id: organisation.id, user_id: user.id)
		  i = i + 1
		end

		i = 0

		## Generate events
		while i < 30 do
		  incident = Incident.find(Incident.pluck(:id).shuffle.first)
		  user = User.find(User.pluck(:id).shuffle.first)

		  Event.create(date_event: incident.date_receive + Random.rand(5), description: SecureRandom.urlsafe_base64(50), incident_id: incident.id, user_id: user.id)
		  Event.create(date_event: incident.date_receive + Random.rand(5), description: SecureRandom.urlsafe_base64(50), incident_id: incident.id, user_id: user.id)
		  Event.create(date_event: incident.date_receive + Random.rand(5), description: SecureRandom.urlsafe_base64(50), incident_id: incident.id, user_id: user.id)
		  Event.create(date_event: incident.date_receive + Random.rand(5), description: SecureRandom.urlsafe_base64(50), incident_id: incident.id, user_id: user.id)
		  i = i + 1
		end


		i = 0

		# Generate Departures
		while i < 30 do
		  incident = Incident.find(Incident.pluck(:id).shuffle.first)
		  user = User.find(User.pluck(:id).shuffle.first)
		  Departure.create(date_start: incident.date_receive + 100, description: SecureRandom.urlsafe_base64(20), incident_id: incident.id, user_id: user.id)
		  i = i + 1
		end

		i = 0
		# Generate Botnets
		while i < 30 do
		  Botnet.create(name: "ER0#{i}#{Random.rand(11000)}", description: SecureRandom.urlsafe_base64(20))
		  i = i + 1
		end


		i = 0
		# Generate CC
		while i < 30 do
		  botnet = Botnet.find(Botnet.pluck(:id).shuffle.first)
		  RemoteControlCenter.create(name: SecureRandom.urlsafe_base64(6), botnet_id: botnet.id, ip: "8.10.#{i + Random.rand(50)}.1", domain: SecureRandom.urlsafe_base64(6), description: SecureRandom.urlsafe_base64(6))
		  RemoteControlCenter.create(name: SecureRandom.urlsafe_base64(6), botnet_id: botnet.id, ip: "78.10.#{i + Random.rand(50)}.1", domain: SecureRandom.urlsafe_base64(6), description: SecureRandom.urlsafe_base64(6))
		  RemoteControlCenter.create(name: SecureRandom.urlsafe_base64(6), botnet_id: botnet.id, ip: "152.10.#{i + Random.rand(50)}.1", domain: SecureRandom.urlsafe_base64(6), description: SecureRandom.urlsafe_base64(6))
		  RemoteControlCenter.create(name: SecureRandom.urlsafe_base64(6), botnet_id: botnet.id, ip: "106.10.#{i + Random.rand(50)}.1", domain: SecureRandom.urlsafe_base64(6), description: SecureRandom.urlsafe_base64(6))

		  RemoteControlCenter.create(name: SecureRandom.urlsafe_base64(6), botnet_id: botnet.id, domain: SecureRandom.urlsafe_base64(6), description: SecureRandom.urlsafe_base64(6))
		  i = i + 1
		end


		i = 0

		## Generate SVT
		while i < 100 do
		  botnet = Botnet.find(Botnet.pluck(:id).shuffle.first)
		  incident = Incident.find(Incident.pluck(:id).shuffle.first)
		  organisation = Organisation.find(Organisation.pluck(:id).shuffle.first)
		  InfectedMachine.create(mac: SecureRandom.urlsafe_base64(20), name: SecureRandom.urlsafe_base64(20), ip: "10.0.#{Random.rand(50) + i}.1", incident_id: incident.id, botnet_id: botnet.id, organisation_id: organisation.id)
		  i = i + 1
		end


		i = 0
		## Generate Relationships
		while i < 100 do
		  remote_control_center = RemoteControlCenter.find(RemoteControlCenter.pluck(:id).shuffle.first)
		  incident = Incident.find(Incident.pluck(:id).shuffle.first)
		  Relationship.create(incident_id: incident.id, remote_control_center_id: remote_control_center.id)
		  Relationship.create(incident_id: incident.id, remote_control_center_id: remote_control_center.id)
		  Relationship.create(incident_id: incident.id, remote_control_center_id: remote_control_center.id)
		  Relationship.create(incident_id: incident.id, remote_control_center_id: remote_control_center.id)
		  Relationship.create(incident_id: incident.id, remote_control_center_id: remote_control_center.id)
		  Relationship.create(incident_id: incident.id, remote_control_center_id: remote_control_center.id)
		  Relationship.create(incident_id: incident.id, remote_control_center_id: remote_control_center.id)
		  Relationship.create(incident_id: incident.id, remote_control_center_id: remote_control_center.id)
		  Relationship.create(incident_id: incident.id, remote_control_center_id: remote_control_center.id)
		  Relationship.create(incident_id: incident.id, remote_control_center_id: remote_control_center.id)
		  i = i + 1
		end


		i = 0

		## Generate organisations

		while i < 30 do
		  organisation = Organisation.create(name: "Organisation_#{Random.rand(11000)}", address: SecureRandom.urlsafe_base64(9), contact_tech: Random.rand(11000), contact_security: Random.rand(11000), ip: Random.rand(11000), region: "РЦМ", handler: SecureRandom.urlsafe_base64(9), description: SecureRandom.urlsafe_base64(20))
		  user = User.find(User.pluck(:id).shuffle.first)
		  month = Random.rand(11)
		  Incident.create(date_receive: "2017-#{month}-09", date_incident: "2017-#{month}-08", date_close: "2017-#{month}-15", state: "closed", description: SecureRandom.urlsafe_base64(20), source: "СООР", current_state: SecureRandom.urlsafe_base64(20), docs: SecureRandom.urlsafe_base64(10), organisation_id: organisation.id, user_id: user.id)

		  i = i + 1
		end
	end
end
