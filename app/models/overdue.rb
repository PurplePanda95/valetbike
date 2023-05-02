class Overdue < ApplicationRecord
    validates_presence_of :user_id, :time_over
    belongs_to :user, class_name: :User, foreign_key: :user_id, optional: false
    def cost
        time_over * 10
    end
end
