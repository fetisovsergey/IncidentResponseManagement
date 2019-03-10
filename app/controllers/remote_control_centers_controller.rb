class RemoteControlCentersController < ApplicationController
  before_action :set_remote_control_center, only: [:show, :edit, :update, :destroy]

  # GET /remote_control_centers
  # GET /remote_control_centers.json
  def index
    @q = (params[:search].blank? ? RemoteControlCenter : RemoteControlCenter.search(params[:search])).ransack(params[:q])

    @remote_control_centers = @q.result.page(params[:page])

    @countries = (params[:search].blank? ? RemoteControlCenter : @remote_control_centers).pluck(:country).compact.sort.uniq
  end

  # GET /remote_control_centers/1
  # GET /remote_control_centers/1.json
  def show
    @q = @remote_control_center.incidents.state_asc.ransack(params[:q])
    @incidents = @q.result.page(params[:page])
  end

  # GET /remote_control_centers/new
  def new
    @remote_control_center = RemoteControlCenter.new(botnet_id: params[:botnet_id])
  end

  # GET /remote_control_centers/1/edit
  def edit
  end

  # POST /remote_control_centers
  # POST /remote_control_centers.json
  def create
    @remote_control_center = RemoteControlCenter.new(remote_control_center_params)

    respond_to do |format|
      if @remote_control_center.save
        format.html { redirect_to @remote_control_center, notice: 'Remote control center was successfully created.' }
        format.json { render :show, status: :created, location: @remote_control_center }
      else
        format.html { render :new }
        format.json { render json: @remote_control_center.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /remote_control_centers/1
  # PATCH/PUT /remote_control_centers/1.json
  def update
    respond_to do |format|
      if @remote_control_center.update(remote_control_center_params)
        format.html { redirect_to @remote_control_center, notice: 'Remote control center was successfully updated.' }
        format.json { render :show, status: :ok, location: @remote_control_center }
      else
        format.html { render :edit }
        format.json { render json: @remote_control_center.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /remote_control_centers/1
  # DELETE /remote_control_centers/1.json
  def destroy
    @remote_control_center.destroy
    redirect_to botnet_path(@remote_control_center.botnet)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_remote_control_center
      @remote_control_center = RemoteControlCenter.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def remote_control_center_params
      params.require(:remote_control_center).permit(:botnet_id, :ip, :domain, :country, :description, :name)
    end
end
