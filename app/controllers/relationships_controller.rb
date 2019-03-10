class RelationshipsController < ApplicationController
  before_action :set_relationship, only: [:edit, :update, :destroy]

  # GET /relationships/new
  def new
    @incident = Incident.find(params[:incident_id])

    if @incident.present?
      @relationship = Relationship.new(incident_id: params[:incident_id])
    else
      redirect_to root_path
    end
  end

  # POST /relationships
  # POST /relationships.json
  def create
    @relationship = Relationship.new(relationship_params)
    
    @incident = @relationship.incident

    if @relationship.save
      redirect_to @incident
    else
      respond_to do |format|
        format.html { render :new }
        format.json { render json: @relationship.errors, status: :unprocessable_entity }
      end
    end

  end

  # PATCH/PUT /relationships/1
  # PATCH/PUT /relationships/1.json
  def update
    @incident = @relationship.incident

    if @relationship.update(relationship_params)
      redirect_to @incident
    else
      respond_to do |format|
        format.html { render :new }
        format.json { render json: @relationship.errors, status: :unprocessable_entity }
      end
    end

  end

  # DELETE /relationships/1
  # DELETE /relationships/1.json
  def destroy
    @relationship.destroy
    redirect_to @relationship.incident
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_relationship
      @relationship = Relationship.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def relationship_params
      params.require(:relationship).permit(:incident_id, :remote_control_center_id)
    end
end
