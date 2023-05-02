class Membership < ApplicationRecord
    
    validates_uniqueness_of :identifier, 
                            :name,
                            :position
    validates_presence_of   :identifier,
                            :name,
                            :position,
                            :cost
    has_many :membership_assignments
    before_validation :set_default_position,
        if: Proc.new {|t| t.position.blank? || t.position < 0 }
    
    def price_in_cents
        (cost * 100).to_i
    end
    
    private
    def set_default_position
        max = Membership.maximum(:position) || 0
        self.position = max + 1
    end
end
