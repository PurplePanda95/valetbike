class Station < ApplicationRecord
  validates_presence_of    :identifier,
                           :name,
                           :address,
                           :num_docks
  validates_uniqueness_of  :identifier
  
  # validates_inclusion_of :has_kiosk, :in => [true, false]
  has_many :docked_bikes, class_name: :Bike, foreign_key: :current_station_id
  def getAddress 
    address
  end
  
  def has_bikes
    if docked_bikes >= 1
        return true
    end
    false
  end

  def get_num_docks
    num_docks
  end

  def get_num_bikes
    #return number of bikes docked at Station
    docked_bikes.count
  end

  def get_available_docks
    #return number of empty docks at station
    num_docks - docked_bikes.count
  end

  def available_docks
    current_docks = docked_bikes.map {|bike| bike.get_dock}
    all_docks = [*1..num_docks]
    all_docks.excluding(current_docks)
    # use map to get docks_ids
    # hash set exclusion 
  end

  def get_available_dock
    available_docks.first
  end

  def docks_with_bikes
    #all_docks = Array.new(num_docks)
    all_docks = [*1..num_docks]
    docked_bikes.order(dock_id: :asc).each do |bike|
      all_docks[bike.dock_id - 1] = bike
    end
    all_docks
  end
end
