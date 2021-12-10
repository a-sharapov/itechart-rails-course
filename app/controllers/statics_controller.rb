class StaticsController < ApplicationController
  before_action :set_static, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: %i[index show]

  # GET /statics or /statics.json
  def index
    @static = Static.new
    @statics = Static.all
  end

  # GET /statics/1 or /statics/1.json
  def show
    @statics = Static.all
  end

  # GET /statics/new
  def new
    @static = Static.new
  end

  # GET /statics/1/edit
  def edit; end

  # POST /statics or /statics.json
  def create
    @static = Static.new(static_params)

    respond_to do |format|
      if @static.save
        format.html { redirect_to @static, notice: 'Static was successfully created.' }
        format.json { render :show, status: :created, location: @static }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @static.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /statics/1 or /statics/1.json
  def update
    respond_to do |format|
      if @static.update(static_params)
        format.html { redirect_to @static, notice: 'Static was successfully updated.' }
        format.json { render :show, status: :ok, location: @static }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @static.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /statics/1 or /statics/1.json
  def destroy
    @static.destroy
    respond_to do |format|
      format.html { redirect_to statics_url, notice: 'Static was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_static
    @static = begin
      Static.friendly.find(params[:id])
    rescue StandardError
      not_found
    end
  end

  # Only allow a list of trusted parameters through.
  def static_params
    params.require(:static).permit(:title, :content, :introtext, :slug)
  end
end
