class RentalsController < ApplicationController
  def show
    @rental = Rental.find(params[:id])
    @bike = @rental.bike
    @renter = @rental.renter
  end

  def new
    @bike = Bike.find(params[:id])
    @rental = Rental.new
  end

  def create
    @rental = Rental.new(rental_params)
    if @rental.save
      bike = Bike.find(@rental.bike_id)
      #bike.current_station_id=nil
      bike.update(current_station: nil, current_station_id: nil, dock_id: nil)
      redirect_to(pages_success_path)
    else
      @rental.get_bike
      render('new')
    end
  end
  
  def return
    station_id = params[:id]
    if Station.find_by_id(station_id)
      if params[:submit]
        @rental = current_user.rentals.order(created_at: :desc).first
        @rental.update(end_time: Time.now)
        bike = @rental.bike
        bike.update(current_station: Station.find(station_id), dock_id: params[:dock_id])
        redirect_to(rentals_path)
        flash[:return_success] = "Bike returned successfully!"
      else params[:submit_station]
        #render('rentals/return_with_docks')
        redirect_to :action => "begin_return",:id => station_id
      end
    else
      flash[:return_failure] = "Please select a valid station"
      @stations = Station.all.order(identifier: :asc)
      render('begin_return')
    end
  end

  def begin_return 
    @station = Station.find_by_id(params[:id])
    puts @station
    @stations = Station.all.order(identifier: :asc)
  end

  def index
  end

  def confirm
  end

  private 

  def rental_params 
    params.require(:rental).permit(:bike_id, :renter_id)
  end
  def return_rental_params
    #params.require(:rental).permit(:dock_id, :end_time)
    params.require(:station_id)
    params.require(:dock_id)
  end

end
