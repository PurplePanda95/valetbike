class Bike < ApplicationRecord
  validates_presence_of    :identifier#,
                           #:dock_id

  
  validates_uniqueness_of  :identifier#,
                           #:dock_id
  
  belongs_to :current_station, class_name: :Station, foreign_key: :current_station_id, optional: true

  has_many :rentals, class_name: :Rental, foreign_key: :bike_id

  # belongs_to: user, class_name: :User, foreign_key: :user_id, optional: true

  before_validation :set_default_dock, if: Proc.new {|t| t.current_station && (t.dock_id.blank? || t.dock_id < 1) }
  validate :validate_dock, if: Proc.new {|t| t.current_station }
  validate :validate_station

  attr_accessor :current_station_id


  def get_station()
    current_station_id
  end

  def get_ride()
    rental_id
  end

  def get_dock()
    dock_id
  end

  def get_status()
    if (get_ride != nil)
      get_ride()
    else
      get_dock()
    end
  end
  def assign_dock
    current_station.available_docks.first
  end

  private
    def set_default_dock
      max = Bike.where(current_station: self.current_station).maximum(:dock_id) || 0
      self.dock_id = max + 1
    end
    
    def validate_dock
      unless current_station_id.present?
        return
      end
      this_station_bikes = Bike.where(current_station: self.current_station)
      this_station_bikes = this_station_bikes.where(dock_id: dock_id)
      if this_station_bikes && this_station_bikes.count > 0
        errors.add(:dock_id, "must be unique at this station")
      end
      if dock_id > Station.find(self.current_station_id).get_num_docks || dock_id < 1
        errors.add(:dock_id, "must be a valid dock")
      end
    end
    
    def validate_station
      if current_station_id.present?
        if current_station.get_available_docks < 1
          errors.add(:current_station, "must have available docks")
        end
      end
    end
    
    
end
