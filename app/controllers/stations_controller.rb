class StationsController < ApplicationController
  
  def index
    @stations = Station.all.order(identifier: :asc)
  end
  def new
    @station = Station.new

  end
  def show
    @station = Station.find(params[:id])
    @num_dock = @station.get_num_docks
  end
  def create
    @station = Station.new(station_params)
    if @station.save
      redirect_to(stations_path)
    else
      render('new')
    end
  end

  def edit
    @station = Station.find(params[:id])
  end

  def update
    @station = Station.find(params[:id])
    if @station.update(station_params)
      redirect_to(stations_path)
    else
      render('edit')
    end
  end

  def delete
    @station = Station.find(params[:id])
  end

  def destroy
    @station = Station.find(params[:id])
    @station.destroy
    redirect_to(stations_path)
  end
  private
  
  def station_params
    params.require(:station).permit(:name, :address, :identifier, :num_docks)
  end
end
