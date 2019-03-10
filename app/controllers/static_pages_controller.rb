class StaticPagesController < ApplicationController
  def home
    @q = Incident.active.ransack(params[:q])
    @incidents = @q.result.page(params[:page])
  end

  def analytics
    ## All Objects
    botnets = Botnet.all
    users = User.all
    incidents = Incident.all
    remote_control_centers = RemoteControlCenter.all
    organisations = Organisation.all
    ##

    @botnet_remote_contol_centers_diagram = botnets
      .collect { |botnet| [botnet.name, botnet.remote_control_centers.count] }
      .delete_if { |botnet, count| count == 0 }
      .sort_by { |botnet, count| -count }

    @botnet_infected_machines_diagram = botnets
      .collect { |botnet| [botnet.name, botnet.infected_machines.count] }
      .delete_if { |botnet, count| count == 0 }
      .sort_by { |botnet, count| -count }

    @remote_control_center_countries_diagram = remote_control_centers
      .pluck(:country)
      .compact
      .sort
      .each_with_object(Hash.new(0)) { |country,count| count[country] += 1 }
      .sort_by { |name, count| -count }

    @organisation_regions_diagram = organisations
      .pluck(:region)
      .compact
      .sort
      .each_with_object(Hash.new(0)) { |region,count| count[region] += 1 }
      .sort_by { |name, count| -count }


    @user_incidents_diagram = users
      .collect { |user| [user.short_name, user.incidents.count] }
      .delete_if { |user, count| count == 0 }
      .sort_by { |user, count| -count }

    @user_departures_diagram = users
      .collect { |user| [user.short_name, user.departures.count] }
      .delete_if { |user, count| count == 0 }
      .sort_by { |user, count| -count }


    @botnet_incidents_diagram = botnets
      .collect { |botnet| [botnet.name, botnet.incidents.count] }
      .delete_if { |botnet, count| count == 0 }
      .sort_by { |botnet, count| -count }


    @source_incidents_diagram = incidents
    .pluck(:source)
    .compact
    .sort
    .each_with_object(Hash.new(0)) { |source, count| count[source] += 1 }.sort_by { |name, count| -count }

    @incident_time_diagram = incidents
      .collect { |incident| ["№#{incident.identificator}", (incident.date_receive...(incident.active? ? Time.now : incident.date_close)).count] }
      .sort_by { |incident, count| -count }
      .first(30)

    respond_to do |format|
      format.html { render :analytics }

      format.pdf do
        file_name = "#{I18n.t 'analytics'}.pdf"
        @pdf = render_to_string pdf: file_name, template: 'static_pages/analytics.pdf.slim', encoding: 'utf8'
        send_data(@pdf, filename: file_name, type: 'application/pdf')
      end
    end
  end

  def incident_analytics
    # For period
    date_start = params[:date_start].blank? ? Time.now - 5.years : params[:date_start].to_time
    date_finish = params[:date_finish].blank? ? Time.now : params[:date_finish].to_time

    params[:date_start] = (date_start < date_finish) ? date_start : date_finish
    params[:date_finish] = (date_finish > date_start) ? date_finish : date_start

    ## All Objects
    botnets = Botnet.all
    incidents = Incident.closed.where(date_receive: params[:date_start]..params[:date_finish])

    users = User.where(id: incidents.pluck(:user_id))

    organisation_ids = incidents.pluck(:organisation_id).sort.uniq

    relationships = Relationship.where(incident_id: incidents.pluck(:id))

    remote_control_center_ids = relationships
      .pluck(:remote_control_center_id)
      .sort
      .uniq
    #######

    @remote_contol_centers_count = RemoteControlCenter
      .where(id: remote_control_center_ids)
      .count

    @infected_machines_count = InfectedMachine
      .where(incident_id: incidents.pluck(:id))
      .count

    @closed_incidents_count = incidents.count

    @departures_count = Departure
      .where(incident_id: incidents.pluck(:id))
      .count
    ########

    @botnet_remote_contol_centers_diagram = botnets
      .collect { |botnet| [botnet.name, botnet.remote_control_centers.where(id: remote_control_center_ids).count] }
      .delete_if { |botnet, count| count == 0 }
      .sort_by { |botnet, count| -count }

    @botnet_infected_machines_diagram = botnets
      .collect { |botnet| [botnet.name, botnet.infected_machines.where(incident_id: incidents.pluck(:id)).count] }
      .delete_if { |botnet, count| count == 0 }
      .sort_by { |botnet, count| -count }

    @remote_control_center_countries_diagram = RemoteControlCenter
      .where(id: remote_control_center_ids)
      .pluck(:country)
      .compact
      .sort
      .each_with_object(Hash.new(0)) { |country,count| count[country] += 1 }
      .sort_by { |name, count| -count }

    @organisation_regions_diagram = Organisation
      .where(id: organisation_ids)
      .pluck(:region)
      .compact
      .sort
      .each_with_object(Hash.new(0)) { |region,count| count[region] += 1 }
      .sort_by { |name, count| -count }

    @user_incidents_diagram = users
      .collect { |user| [user.short_name, user.incidents.where(id: incidents.pluck(:id)).count] }
      .delete_if { |user, count| count == 0 }
      .sort_by { |user, count| -count }

    @user_departures_diagram = users
      .collect { |user| [user.short_name, user.departures.where(incident_id: incidents.pluck(:id)).count] }
      .delete_if { |user, count| count == 0 }
      .sort_by { |user, count| -count }

    @botnet_incidents_diagram = botnets
      .collect { |botnet| [botnet.name, botnet.incidents.where(id: incidents.pluck(:id)).count] }
      .delete_if { |botnet, count| count == 0 }
      .sort_by { |botnet, count| -count }

    @source_incidents_diagram = incidents
      .pluck(:source)
      .compact
      .sort
      .each_with_object(Hash.new(0)) { |source,count| count[source] += 1 }
      .sort_by { |name, count| -count }

    @incident_time_diagram = incidents
      .collect { |incident| ["№#{incident.identificator}", (incident.date_receive...(incident.active? ? Time.now : incident.date_close)).count] }
      .sort_by { |incident, count| -count }
      .first(30)

    respond_to do |format|
      format.html { render :incident_analytics }

      format.pdf do
        file_name = "#{I18n.t 'incident_analytics'}_#{params[:date_start].strftime('%F')}_#{params[:date_finish].strftime('%F')}.pdf"
        @pdf = render_to_string pdf: file_name, template: 'static_pages/incident_analytics.pdf.slim', encoding: 'utf8'
        send_data(@pdf, filename: file_name, type: 'application/pdf')
      end
    end
  end

  def statistic
    # For Current time
    @active_incidents_count = Incident.active.count
    @closed_incidents_count = Incident.closed.count

    @departures_count = Departure.count
    @documents_count = Document.count

    # For period
    date_start = params[:date_start].blank? ? Time.now - 1.months : params[:date_start].to_time
    date_finish = params[:date_finish].blank? ? Time.now : params[:date_finish].to_time

    params[:date_start] = (date_start < date_finish) ? date_start : date_finish
    params[:date_finish] = (date_finish > date_start) ? date_finish : date_start

    @active_incidents = Incident.where(
      'date_receive <= ? AND (date_close > ? OR date_close IS NULL)',
      params[:date_finish],
      params[:date_finish]
    )

    @departures_at_time = Departure.where(date_start: params[:date_start]..params[:date_finish])

    @documents_at_time = Document.where(date_signature: params[:date_start]..params[:date_finish])

    @closed_incidents = Incident.where(date_close: params[:date_start]..params[:date_finish]).date_close_desc
  end

  def export_db_seeds
    # Generate actual seeds.rb file
    %x[rake db:seed:dump]

    # Send Seeds.rb file
    send_file("#{Rails.root}/db/seeds.rb")
  end

  def export_db_json
    # To load all models app/models/**/*.rb
    Rails.application.eager_load!

    data = ""

    ActiveRecord::Base.descendants.each do |model|
      if model.name.exclude?("Record")

        data += "\n#{model.name}:\n"

        model.all.each do |model_object|
          data += "#{model_object.to_json}\n"
        end

      end
    end

    send_data(data, type: 'application/json; header=present', disposition: "attachment; filename=db.json")
  end
end
