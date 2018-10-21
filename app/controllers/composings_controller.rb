class ComposingsController < ApplicationController
  before_action :set_composing, only: [:show, :edit, :update, :destroy]

  # GET /composings
  # GET /composings.json
  def index
    @composings = Composing.all
  end

  # GET /composings/1
  # GET /composings/1.json
  def show
  end

  # GET /composings/new
  def new
    @composing = Composing.new
  end

  # GET /composings/1/edit
  def edit
  end

  # POST /composings
  # POST /composings.json
  def create
    @composing = Composing.new(composing_params)

    respond_to do |format|
      if @composing.save
        format.html { redirect_to @composing, notice: 'Composing was successfully created.' }
        format.json { render :show, status: :created, location: @composing }
      else
        format.html { render :new }
        format.json { render json: @composing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /composings/1
  # PATCH/PUT /composings/1.json
  def update
    respond_to do |format|
      if @composing.update(composing_params)
        format.html { redirect_to @composing, notice: 'Composing was successfully updated.' }
        format.json { render :show, status: :ok, location: @composing }
      else
        format.html { render :edit }
        format.json { render json: @composing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /composings/1
  # DELETE /composings/1.json
  def destroy
    @composing.destroy
    respond_to do |format|
      format.html { redirect_to composings_url, notice: 'Composing was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def import
    Composing.my_import(params[:file])
    redirect_to composings_path, notice: 'Successfully imported data!'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_composing
      @composing = Composing.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def composing_params
      params.fetch(:composing, {})
    end
end
