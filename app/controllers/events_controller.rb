class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy, :clear]
  before_action :set_query

  # GET /events
  # GET /events.json
  def index
    @q = Event.includes(:works, :works => [:authors, :composers]).ransack(params[:q])
    
    @events = @q.result(distinct: true).paginate(:page => params[:page], :per_page => 14).order(:date)
  end

  # GET /events/1
  # GET /events/1.json
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(allowed_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def import
    Event.my_import(params[:file])
    redirect_to root_url, notice: 'Successfully imported data!'
  end

  def clear
    session[:query] = nil
    redirect_to @event
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.friendly.find(params[:id])
    end

    def set_query
      # if request.referer.include? "works"
      #   session[:query] = nil
      # else
        session[:query] = params[:q] if params[:q]
      # end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.fetch(:event, {})
    end

    def allowed_params
      params.require(:event).permit(:date, :receipts, :kind, :zinzendorf, :double, :notes)
    end
end
