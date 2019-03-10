class IncidentsController < ApplicationController
  before_action :set_incident, only: [:show, :edit, :update, :destroy, :open, :close]

  # GET /active_incidents
  def active_incidents
    @q = Incident.active.ransack(params[:q])
    @incidents = @q.result.page(params[:page])
  end

  # GET /closed_incidents
  def closed_incidents
    @q = Incident.closed.date_close_desc.ransack(params[:q])
    @incidents = @q.result.page(params[:page])
  end

  # GET /incidents/1
  def show
    @event = Event.new(incident_id: @incident.id) if @incident.active?

    @events = @incident.events

    @departures = @incident.departures.date_start_asc

    @documents = @incident.documents.date_signature_asc

    @remote_control_centers = @incident.remote_control_centers

    @infected_machines = @incident.infected_machines

    respond_to do |format|
      format.html { render :show }

      format.pdf do
        file_name = "#{[@incident.identificator, @incident.source].join('_')} #{@incident.organisation.name[0,36]} #{@incident.user.surname}.pdf"
        @pdf = render_to_string pdf: file_name, template: 'incidents/show.pdf.slim', encoding: 'utf8'
        send_data(@pdf, filename: file_name, type: 'application/pdf')
      end
    end
  end

  # GET /incidents/new
  def new
    @incident = Incident.new(organisation_id: params[:organisation_id])
  end

  # GET /incidents/1/edit
  def edit
  end

  # POST /incidents
  # POST /incidents.json
  def create
    @incident = Incident.new(incident_params)

    respond_to do |format|
      if @incident.save
        format.html { redirect_to @incident, notice: 'Incident was successfully created.' }
        format.json { render :show, status: :created, location: @incident }
      else
        format.html { render :new }
        format.json { render json: @incident.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /incidents/1
  # PATCH/PUT /incidents/1.json
  def update
    respond_to do |format|
      if @incident.update(incident_params)
        format.html { redirect_to @incident, notice: 'Incident was successfully updated.' }
        format.json { render :show, status: :ok, location: @incident }
      else
        format.html { render :edit }
        format.json { render json: @incident.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /incidents/1
  # DELETE /incidents/1.json
  def destroy
    @incident.destroy
    respond_to do |format|
      format.html { redirect_to incidents_url, notice: 'Incident was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def close
    if @incident.active?
      @incident.close!
      @incident.set_close_date
    end

    redirect_to incident_path(@incident)
  end

  def open
    if @incident.closed?
      @incident.open!
      @incident.unset_close_date
    end

    redirect_to incident_path(@incident)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_incident
      @incident = Incident.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def incident_params
      params.require(:incident).permit(:date_receive, :date_close, :date_incident, :state, :description, :source, :user_id, :current_state, :organisation_id, :identificator)
    end
end
