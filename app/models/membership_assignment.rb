class MembershipAssignment < ApplicationRecord
  belongs_to :user
  belongs_to :membership
  validates_presence_of :start
  validate :no_other_paid_active

  after_validation :add_end, if: Proc.new {|t| t.end.blank?}
  scope :nil_end, -> {where(end: nil)}
  scope :end_before, -> (end_time) {where("end > ?", end_time)}
  scope :un_expired, -> (now = Time.now) {nil_end.or(end_before(now)).order(created_at: :desc)}
  def end_to_string
    if self.membership.cost == 0
      "the end of eternity"
    else
      self.end.strftime("%B %-d, %Y at %I:%M %P")
    end
  end
  def is_expired?
    if self.membership.cost == 0
      return false
    end
    self.end > Time.now
  end
  private
  def add_end
    membership = Membership.find(membership_id)
    if membership.cost == 0 || self.end.present?
      puts "hoho"
      return
    end
    time_unit = membership.time_unit
    frequency = membership.payment_frequency
    if time_unit == "month" || time_unit == "months" 
      self.end = start + frequency.month
    elsif time_unit == "year" || time_unit == "years"
      self.end = start + frequency.year
    elsif time_unit == "minute" || time_unit == "minutes"
      self.end = start + frequency.minute
    elsif time_unit == "day" || time_unit == "days"
      self.end = start + frequency.day
    elsif time_unit == "hour" || time_unit == "hours"
      self.end = start + frequency.hour
    else
      self.end = start + frequency
    end
  end
  def no_other_paid_active
    if user.has_active_membership? && user.get_membership.cost != 0 && user.get_membership_assignment != self
      puts "problem child"
      errors.add(:membership_id, "must not have current paid membership. Cancel membership before adding new one.")
    end
  end
end
# MembershipAssignment.where(end: nil).or(MemberhsipAssignment.where.not("end > ?", Time.now)).order(created_at: :desc)