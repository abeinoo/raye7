class TripsController < ApplicationController
  load_and_authorize_resource
  before_action :set_trip, only: [:show, :edit, :update, :destroy, :join_trip]

  # GET /trips
  # GET /trips.json
  def index
    if current_user.admin?
      @trips = Trip.all
    else
      @trips = Trip.where("time >= ?", DateTime.now)
    end
  end

  # GET /trips/1
  # GET /trips/1.json
  def show
    respond_to do |format|
      format.js
    end
  end

  # GET /trips/new
  def new
    @trip = Trip.new
  end

  # GET /trips/1/edit
  def edit
  end

  # POST /trips
  # POST /trips.json
  def create
    @trip = Trip.new(trip_params)
    @trip.user = current_user
    respond_to do |format|
      if @trip.save
        format.html { redirect_to trips_path, notice: 'Trip was successfully created.' }
        format.json { render :show, status: :created, location: @trip }
      else
        format.html { render :new }
        format.json { render json: @trip.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trips/1
  # PATCH/PUT /trips/1.json
  def update
    respond_to do |format|
      if @trip.update(trip_params)
        format.html { redirect_to @trip, notice: 'Trip was successfully updated.' }
        format.json { render :show, status: :ok, location: @trip }
      else
        format.html { render :edit }
        format.json { render json: @trip.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trips/1
  # DELETE /trips/1.json
  def destroy
    @trip.destroy
    respond_to do |format|
      format.html { redirect_to trips_url, notice: 'Trip was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def join_trip
    UsersTrip.create(trip_id: @trip.id, user_id: current_user.id)
    respond_to do |format|
      format.html { redirect_to trips_url, notice: 'successfully joined the trip.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trip
      @trip = Trip.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def trip_params
      params.require(:trip).permit(:time, :source, :destination)
    end
end
