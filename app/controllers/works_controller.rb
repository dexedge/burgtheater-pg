class WorksController < ApplicationController
  before_action :set_work, only: [:show, :edit, :update, :destroy]
  before_action :authorize, only: [:edit, :update]

  # GET /works
  # GET /works.json
  def index
    # Sort "Concert", "Theater closed", and "unknown" to end of title list
    works = Work.all.includes(:authors, :composers)

    # Ignore leading definite and indefinite articles in sort, and sort umlauted characters to proper alphabetical position
    
    works1 = works.where.not(genre: ["Concert", "Closed", "Unknown"]).sort_by {|w| w.title.downcase.sub(/ö/,"oe").sub(/ä/,"ae")}
    
    # works.where.not(genre: ["Concert", "Closed", "Unknown"]).sort_by {|w| w.title.downcase}

    works2 = works.where(genre: ["Concert", "Closed", "Unknown"]).sort_by(&:title)

    @works = works1 + works2

  end

  # GET /works/1
  # GET /works/1.json
  def show
    # Collect the performances for this work, omitting any where receipts = "NA", which would break sorting on that column
    # performances = Event.includes(:works).where(works: {id: @work.id}).where.not(receipts: "NA")
    performances = @work.events.where.not(receipts: "NA")

    case params[:column]
    when "date"
      @performances = performances.order(sort_column + " " + sort_direction)
    when "receipts"
      perf_unknown = performances.where(receipts: "unknown")
      perf_known = performances.where.not(receipts: "unknown")

      @performances = perf_unknown.order(:date) + perf_known.order(sort_column + "::integer"+ " " + sort_direction)
    else
      @performances = performances.order(:date)
    end
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

    # White list for sortable columns
    def sortable_columns
      ["date", "receipts"]
    end
end
