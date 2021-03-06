class WorksController < ApplicationController
  before_action :set_work, only: [:show, :edit, :update, :destroy, :clear]
  before_action :set_query
  before_action :authorize, only: [:edit, :update]

  # GET /works
  # GET /works.json
  def index
    @q = Work.ransack(params[:q])
    
    # sortable_title is downcased, with leading articles removed and umlauted characters change to form with 'e'
    @works = @q.result(distinct: true).includes(:authors, :composers).paginate(:page => params[:page], :per_page => 14).order(sortable_title: :asc)
    
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
    when "dow"
      @performances = performances.order("to_char(date, 'D') " + sort_direction + ", date")
    when "receipts"
      @performances = performances.order(sort_column + "::integer" + " " + sort_direction)
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

  # GET /works/1/authors
  def authors
    @work = Work.friendly.find(params[:id])
    @authors = @work.authors
  end

  # POST /works/1/author_add?author_id=2
  def author_add
    @work = Work.friendly.find(params[:id])
    @author = Author.friendly.find(params[:author])
    unless @work.is_author?(@author)
      @work.authors << @author
      flash[:notice] = "Author added"
    else
      flash[:error] = "Author already attached"
    end
    redirect_to action: "authors", id: @work
  end

  # POST /works/1/author_remove?authors[]=
  def author_remove
    @work = Work.friendly.find(params[:id])
    author_ids = params[:authors]
    unless author_ids.blank?
      author_ids.each do |author_id|
        author = Author.friendly.find(author_id)
        if @work.is_author?(author)
          logger.info "Removing work from author #{author.id}"
          @work.authors.delete(author)
          flash[:notice] = "Author deleted"
        end
      end
    end
    redirect_to action: "authors", id: @work
  end

  def clear
    session[:query] = nil
    redirect_to @work
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_work
      @work = Work.friendly.find(params[:id])
    end

    def set_query
      if request.referer.include? "events"
        session[:query] = nil
      else
        session[:query] = params[:q] if params[:q]
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def work_params
      params.fetch(:work, {})
    end

    def allowed_params
      params.require(:work).permit(:title, :genre, :notes, :image_name, :book_url)
    end

    # White list for sortable columns
    def sortable_columns
      ["date", "dow", "receipts"]
    end
end
