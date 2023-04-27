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
      bike.update(current_station: nil)
      bike.save
      redirect_to(pages_success_path)
    else
      @rental.get_bike
      render('new')
    end
  end
  
  def bike_return
    #@stations = Station.all
    #if params[:submit_id].present?
      #station = Station.find_by(id: params[:identifier])
    #elsif params[:submit_name].present?
      #station = Station.find_by("name LIKE ?", "%#{params[:name]}%")
    #end
    if station.present?
      current_station_id = params[:current_station_id] 
      @rental = current_user.rentals.order(created_at: :desc).first
      @rental.update(end_time: Time.now)
      bike = @rental.bike
      station = Station.find_by(identifier: current_station_id)
      bike.update(current_station: station) 
      @rental.update(distance: 20)
      flash[:return_success] = "Bike returned successfully!"
      redirect_to station_path(station)
    end
  end

  def index
  end

  def confirm
  end

  private 

  def rental_params 
    params.require(:rental).permit(:bike_id, :renter_id)
  end

end



