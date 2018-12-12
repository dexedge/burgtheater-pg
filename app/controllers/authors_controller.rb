class AuthorsController < ApplicationController
  before_action :set_author, only: [:show, :edit, :update, :destroy]
  before_action :authorize, only: [:edit, :update, :create, :new]
  helper_method :sort_column, :sort_direction

  # GET /authors
  # GET /authors.json
  def index
    @authors = Author.all.paginate(:page => params[:page], :per_page => 14).order(lastname: :asc, firstnames: :asc)
    # Sort umlauted characters in lastname correctly
    #@authors = Author.all.sort_by {|a| a.lastname.downcase.sub(/ö/,"oe").sub(/ü/, "ue")}
  end

  # GET /authors/1
  # GET /authors/1.json
  def show
    # Collect the performances for this author, omitting any where receipts = "NA", which would break sorting on that column
    performances = Event.includes(:works => :authors).where(authors: {id: @author.id}).where.not(receipts: "NA")
    
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
      @performances = performances.order(:date)
    end
  end

  # GET /authors/new
  def new
    @author = Author.new
  end

  # GET /authors/1/edit
  def edit
  end

  # POST /authors
  # POST /authors.json
  def create
    @author = Author.new(allowed_params)

    respond_to do |format|
      if @author.save
        format.html { redirect_to @author, notice: 'Author was successfully created.' }
        format.json { render :show, status: :created, location: @author }
      else
        format.html { render :new }
        format.json { render json: @author.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /authors/1
  # PATCH/PUT /authors/1.json
  def update
    respond_to do |format|
      if @author.update(allowed_params)
        format.html { redirect_to @author, notice: 'Author was successfully updated.' }
        format.json { render :show, status: :ok, location: @author }
      else
        format.html { render :edit }
        format.json { render json: @author.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /authors/1
  # DELETE /authors/1.json
  def destroy
    @author.destroy
    respond_to do |format|
      format.html { redirect_to authors_url, notice: 'Author was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  def import
    Author.my_import(params[:file])
    redirect_to authors_path, notice: 'Successfully imported data!'
  end

  # GET /authors/1/works
  def works
    @author = Author.find(params[:id])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_author
      @author = Author.find(params[:id])
    end
  
    # Never trust parameters from the scary internet, only allow the white list through.
    def author_params
      params.fetch(:author, {})
    end

    def allowed_params
      params.require(:author).permit(:lastname, :firstnames, :birth, :death)
    end

    # White list for sortable columns
    def sortable_columns
      ["date", "dow", "title", "receipts"]
    end
end
