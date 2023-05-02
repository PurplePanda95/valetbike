class Rental < ApplicationRecord
    
    belongs_to :bike, class_name: :Bike, foreign_key: :bike_id, optional: false
    belongs_to :renter, class_name: :User, foreign_key: :renter_id, optional: false
    #, #optional: false
    before_create :add_starting_values

    def get_bike
        bike
    end
    def is_ongoing?
        if end_time
            return false
        end
        true
    end
    def is_done?
        if end_time
            return true
        end
        false
    end
    def getTimeElapsed
        if self.is_done? 
            return (end_time - start_time)/60.ceil
        end
        round(Time.now - start_time)
    end
    def getAverageSpeed
        if self.is_ongoing? || !distance
            return nil
        end
        return distance / self.getTimeElapsed
    end
    def is_overdue?
        self.getTimeElapsed > time_limit
    end
    def minutes_over
        unless is_overdue?
            return 0
        end
        self.getTimeElapsed - time_limit
    end
    private
    def add_starting_values
        self.start_time = Time.now
        self.distance = 0
    end
    
end
