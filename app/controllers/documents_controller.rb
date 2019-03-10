class DocumentsController < ApplicationController
  before_action :set_document, only: [:show, :edit, :update, :destroy]

  # GET /documents
  def index
    @q = Document.ransack(params[:q])
    @documents = @q.result.page(params[:page])
  end

  # GET /documents/1
  def show
    @incident = @document.incident
    @user = @document.user
  end

  # GET /documents/new
  def new
    incident = Incident.find(params[:incident_id]) if params[:incident_id].present?

    if incident.present?
      @document = Document.new(incident_id: incident.id)
    else
      redirect_to documents_path
    end
  end

  # GET /documents/1/edit
  def edit
  end

  # POST /documents
  # POST /documents.json
  def create
    @document = Document.new(document_params)

    if @document.save
      redirect_to @document.incident
    else
      respond_to do |format|
        format.html { render :new }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /documents/1
  # PATCH/PUT /documents/1.json
  def update
    if @document.update(document_params)
      redirect_to @document.incident
    else
      respond_to do |format|
        format.html { render :new }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /documents/1
  # DELETE /documents/1.json
  def destroy
    @document.destroy

    redirect_to @document.incident
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_document
      @document = Document.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def document_params
      params.require(:document).permit(:incident_id, :date_signature, :destination, :number, :user_id, :description)
    end
end
