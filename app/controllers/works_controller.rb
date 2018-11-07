class WorksController < ApplicationController
  before_action :set_work, only: [:show, :edit, :update, :destroy]
  before_action :authorize, only: [:edit, :update]

  # GET /works
  # GET /works.json
  def index
    # Sort "Concert", "Theater closed", and "unknown" to end of title list
    works = Work.all.includes(:authors, :composers)
    
    works1 = works.where.not(genre: ["Concert", "Closed", "Unknown"]).sort_by {|w| w.title.downcase.sub(/^der |^das |^die |^i |^gli |^il |^l'|^la |^le |^una /,"")}
    
    # works.where.not(genre: ["Concert", "Closed", "Unknown"]).sort_by {|w| w.title.downcase}

    works2 = works.where(genre: ["Concert", "Closed", "Unknown"]).sort_by(&:title)

    @works = works1 + works2

  end

  # GET /works/1
  # GET /works/1.json
  def show
  end

  # GET /works/new
  def new
    @work = Work.new
  end

  # GET /works/1/edit
  def edit
  end

  # POST /works
  # POST /works.json
  def create
    @work = Work.new(work_params)

    respond_to do |format|
      if @work.save
        format.html { redirect_to @work, notice: 'Work was successfully created.' }
        format.json { render :show, status: :created, location: @work }
      else
        format.html { render :new }
        format.json { render json: @work.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /works/1
  # PATCH/PUT /works/1.json
  def update
    respond_to do |format|
      if @work.update(allowed_params)
        format.html { redirect_to @work, notice: 'Work was successfully updated.' }
        format.json { render :show, status: :ok, location: @work }
      else
        format.html { render :edit }
        format.json { render json: @work.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /works/1
  # DELETE /works/1.json
  def destroy
    @work.destroy
    respond_to do |format|
      format.html { redirect_to works_url, notice: 'Work was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def import
    Work.my_import(params[:file])
    redirect_to works_path, notice: 'Successfully imported data!'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_work
      @work = Work.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def work_params
      params.fetch(:work, {})
    end

    def allowed_params
      params.require(:work).permit(:title, :genre, :notes)
    end
end
