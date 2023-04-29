class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

    EMAIL_REGEX = /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}\Z/i
    PHONE_REGEX = /\A[0-9]{10}\z/

    validates :first_name, presence: true, length: { maximum: 20 }
    validates :last_name, presence: true, length: { maximum: 20 }
    validates :email, presence: true,
                      format: { with: EMAIL_REGEX },
                      length: { maximum: 50 },
                      uniqueness: true,
                      confirmation: true
    #validates :membership_id, presence: true
    #validates :user_id, presence: true
    #validates :card_id, presence: true
    validate :validate_optional_phone_number

    has_many :rentals, class_name: :Rental, foreign_key: :renter_id
    has_many :payments, class_name: :Payment, foreign_key: :user_id
    has_many :membership_assignments, class_name: :MembershipAssignment, foreign_key: :user_id
    has_many :memberships, through: :membership_assignments
    has_many :cards, dependent: :destroy #new

    def get_name
    end

    def get_email
    end

    def has_phone        
    end

    def get_phone
    end

    def is_admin?
        is_admin
    end

    def has_payment_info
    end

    def get_membership
        @membership_assignments
    end
    def get_ongoing_rental
        rentals.order(created_at: :desc).first
    end
    def ongoing_rental?
        rentals.order(created_at: :desc).present? && rentals.order(created_at: :desc).first.is_ongoing?
    end
    #(* reference: belows are from the Ruby Training *)#
    def full_name
        [first_name, last_name].join(' ')
    end

    def last_name_first
        [last_name, first_name].join(', ')
    end

    def abbrev_name
        first_initial = first_name.chars.first + ", "
        [first_initial, last_name].join(' ')
    end

    private
    def validate_optional_phone_number
        unless phone_number.present? 
            return
        end
        unless PHONE_REGEX.match(phone_number)
            errors.add(:phone_number, "must be a valid 10-digit phone number")
        end
    end
    
end

