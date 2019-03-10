class InfectedMachinesController < ApplicationController
  before_action :set_infected_machine, only: [:edit, :update, :destroy, :show]

  # GET /infected_machines/1
  def show
    @incident = @infected_machine.incident
    @organisation = @infected_machine.organisation
  end

  # GET /infected_machines
  def index
    @q = (params[:search].blank? ? InfectedMachine : InfectedMachine.search(params[:search])).ransack(params[:q])
    @infected_machines = @q.result.page(params[:page])
  end

  # GET /infected_machines/new
  def new
    @incident = Incident.find(params[:incident_id]) if params[:incident_id].present?

    if @incident.present?
      @infected_machine = InfectedMachine.new(incident_id: @incident.id, organisation_id: @incident.organisation_id)
    else
      redirect_to infected_machines_path
    end
  end

  # GET /infected_machines/1/edit
  def edit
  end

  # POST /infected_machines
  # POST /infected_machines.json
  def create
    @infected_machine = InfectedMachine.new(infected_machine_params)

    @incident = @infected_machine.incident

    if @infected_machine.save
      redirect_to @infected_machine.incident
    else
      respond_to do |format|
        format.html { render :new }
        format.json { render json: @infected_machine.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /infected_machines/1
  # PATCH/PUT /infected_machines/1.json
  def update
    if @infected_machine.update(infected_machine_params)
      redirect_to @infected_machine
    else
      respond_to do |format|
        format.html { render :new }
        format.json { render json: @infected_machine.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /infected_machines/1
  # DELETE /infected_machines/1.json
  def destroy
    @infected_machine.destroy

    redirect_to @infected_machine.incident
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_infected_machine
      @infected_machine = InfectedMachine.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def infected_machine_params
      params.require(:infected_machine).permit(:incident_id, :mac, :name, :ip, :botnet_id, :organisation_id, :description, :hdd_id)
    end
end
