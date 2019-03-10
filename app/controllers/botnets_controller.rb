class BotnetsController < ApplicationController
  before_action :set_botnet, only: [:show, :edit, :update, :destroy]

  # GET /botnets
  def index
    @q = (params[:search].blank? ? Botnet : Botnet.search(params[:search])).ransack(params[:q])
    @botnets = @q.result.page(params[:page])
  end

  # GET /botnets/1
  def show
    @q = @botnet.remote_control_centers.ransack(params[:q])
    @remote_control_centers = @q.result.page(params[:page])

    @countries = @botnet.countries

    @infected_machines = @botnet.infected_machines.incident_id_asc
  end

  # GET /botnets/new
  def new
    @botnet = Botnet.new
  end

  # GET /botnets/1/edit
  def edit
  end

  # POST /botnets
  # POST /botnets.json
  def create
    @botnet = Botnet.new(botnet_params)

    respond_to do |format|
      if @botnet.save
        format.html { redirect_to @botnet, notice: 'Botnet was successfully created.' }
        format.json { render :show, status: :created, location: @botnet }
      else
        format.html { render :new }
        format.json { render json: @botnet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /botnets/1
  # PATCH/PUT /botnets/1.json
  def update
    respond_to do |format|
      if @botnet.update(botnet_params)
        format.html { redirect_to @botnet, notice: 'Botnet was successfully updated.' }
        format.json { render :show, status: :ok, location: @botnet }
      else
        format.html { render :edit }
        format.json { render json: @botnet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /botnets/1
  # DELETE /botnets/1.json
  def destroy
    @botnet.destroy
    respond_to do |format|
      format.html { redirect_to botnets_url, notice: 'Botnet was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_botnet
      @botnet = Botnet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def botnet_params
      params.require(:botnet).permit(:name, :description)
    end
end
