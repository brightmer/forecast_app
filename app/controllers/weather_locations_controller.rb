class WeatherLocationsController < ApplicationController
  before_action :set_weather_location, only: %i[ show edit update destroy ]

  # GET /weather_locations or /weather_locations.json
  def index
    @weather_locations = WeatherLocation.all
  end

  # GET /weather_locations/1 or /weather_locations/1.json
  def show
  end

  # GET /weather_locations/new
  def new
    @weather_location = WeatherLocation.new
  end

  # GET /weather_locations/1/edit
  def edit
  end

  # POST /weather_locations or /weather_locations.json
  def create
    @weather_location = WeatherLocation.new(weather_location_params)

    respond_to do |format|
      if @weather_location.save
        format.html { redirect_to weather_location_url(@weather_location), notice: "Weather location was successfully created." }
        format.json { render :show, status: :created, location: @weather_location }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @weather_location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /weather_locations/1 or /weather_locations/1.json
  def update
    respond_to do |format|
      if @weather_location.update(weather_location_params)
        format.html { redirect_to weather_location_url(@weather_location), notice: "Weather location was successfully updated." }
        format.json { render :show, status: :ok, location: @weather_location }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @weather_location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /weather_locations/1 or /weather_locations/1.json
  def destroy
    @weather_location.destroy!

    respond_to do |format|
      format.html { redirect_to weather_locations_url, notice: "Weather location was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_weather_location
      @weather_location = WeatherLocation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def weather_location_params
      params.require(:weather_location).permit(:address, :latitude, :longitude, :postal_code, :weather_description, :current_temperature, :high_temperature, :low_temperature, :units, :date_checked)
    end
end
