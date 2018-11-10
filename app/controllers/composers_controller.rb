class ComposersController < ApplicationController
  before_action :set_composer, only: [:show, :edit, :update, :destroy]

  # GET /composers
  # GET /composers.json
  def index
    @composers = Composer.all
  end

  # GET /composers/1
  # GET /composers/1.json
  def show
    # Collect the performances for this author, omitting any where receipts = "NA", which would break sorting on that column
    performances = Event.includes(:works => :composers).where(composers: {id: @composer.id}).where.not(receipts: "NA")
    
    case params[:column]
    when "date"
      @performances = performances.order(sort_column + " " + sort_direction)
    when "dow"
      @performances = performances.order("to_char(date, 'D') " + sort_direction + ", date")
    when "title"
      @performances = performances.order("lower(works." + sort_column + ") " + sort_direction + ", date")
    when "receipts"
      if performances.exists?(receipts: "unknown")
        @performances = performances.order(:date)
      else
        @performances = performances.order(sort_column + "::integer"+ " " + sort_direction)
      end
    else
      @performances = performances.order(:date) # Default
    end
  end

  # GET /composers/new
  def new
    @composer = Composer.new
  end

  # GET /composers/1/edit
  def edit
  end

  # POST /composers
  # POST /composers.json
  def create
    @composer = Composer.new(allowed_params)

    respond_to do |format|
      if @composer.save
        format.html { redirect_to @composer, notice: 'Composer was successfully created.' }
        format.json { render :show, status: :created, location: @composer }
      else
        format.html { render :new }
        format.json { render json: @composer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /composers/1
  # PATCH/PUT /composers/1.json
  def update
    respond_to do |format|
      if @composer.update(allowed_params)
        format.html { redirect_to @composer, notice: 'Composer was successfully updated.' }
        format.json { render :show, status: :ok, location: @composer }
      else
        format.html { render :edit }
        format.json { render json: @composer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /composers/1
  # DELETE /composers/1.json
  def destroy
    @composer.destroy
    respond_to do |format|
      format.html { redirect_to composers_url, notice: 'Composer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def import
    Composer.my_import(params[:file])
    redirect_to composers_path, notice: 'Successfully imported data!'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_composer
      @composer = Composer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def composer_params
      params.fetch(:composer, {})
    end

    def allowed_params
      params.require(:composer).permit(:lastname, :firstnames, :birth, :death)
    end

    # White list for sortable columns
    def sortable_columns
      ["date", "dow", "title", "receipts"]
    end
end
