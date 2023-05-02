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
    if current_user.overdues.present?
      redirect_to account_path
      return
    end
    if !current_user.has_active_membership?
      flash[:error] = "Please select a membership before renting a bike."
      redirect_to add_membership_path
      return
    end
    @rental = Rental.new(rental_params)
    if @rental.save
      @rental.time_limit = current_user.get_membership.time_limit
      @rental.save
      bike = Bike.find(@rental.bike_id)
      #bike.current_station_id=nil
      bike.update(current_station: nil)
      bike.update(current_station_id: nil)
      bike.update(dock_id: nil)
      bike.save
      redirect_to(rental_path(@rental))
    else
      @rental.get_bike
      render('new')
    end
  end
  
  def return
    station_id = params[:station_id]
    @rental = current_user.rentals.order(created_at: :desc).first
    @rental.update(end_time: Time.now)
    if @rental.is_overdue? && @rental.minutes_over >0
      overdue = Overdue.new(user_id: current_user.id, time_over: @rental.minutes_over)
      overdue.save
    end
    bike = @rental.bike
    bike.update(current_station: Station.find(station_id))
    bike.update(dock_id: params[:dock_id])
    bike.save

    redirect_to(stations_path)
    flash[:return_success] = "Bike returned successfully!"
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
    # params.require(:rental).permit(:dock_id, :end_time)
    params.require(:station_id)
    params.require(:dock_id)
  end

end
