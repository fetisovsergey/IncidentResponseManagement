class DeparturesController < ApplicationController
  before_action :set_departure, only: [:show, :edit, :update, :destroy]

  # GET /departures
  def index
    @q = Departure.ransack(params[:q])
    @departures = @q.result.page(params[:page])
  end

  # GET /departures/1
  def show
    @incident = @departure.incident
    @user = @departure.user
  end

  # GET /departures/new
  def new
    incident = Incident.find(params[:incident_id]) if params[:incident_id].present?

    if incident.present?
      @departure = Departure.new(incident_id: incident.id)
    else
      redirect_to departures_path
    end
  end

  # GET /departures/1/edit
  def edit
  end

  # POST /departures
  # POST /departures.json
  def create
    @departure = Departure.new(departure_params)

    if @departure.save
      redirect_to @departure.incident
    else
      respond_to do |format|
        format.html { render :new }
        format.json { render json: @departure.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /departures/1
  # PATCH/PUT /departures/1.json
  def update
    if @departure.update(departure_params)
      redirect_to @departure.incident
    else
      respond_to do |format|
        format.html { render :new }
        format.json { render json: @departure.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /departures/1
  # DELETE /departures/1.json
  def destroy
    @departure.destroy

    redirect_to @departure.incident
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_departure
      @departure = Departure.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def departure_params
      params.require(:departure).permit(:incident_id, :date_start, :user_id, :description)
    end
end
