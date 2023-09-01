class Restaurant < ApplicationRecord
    extend FriendlyId
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
    
    has_many :tables, dependent: :destroy
    has_many :food_items, dependent: :destroy
    has_many :special_menus, dependent: :destroy
    has_many :categories, dependent: :destroy
    has_many :carts, dependent: :destroy
    has_many :orders, dependent: :destroy
    has_many :deleted_orders, dependent: :destroy
    has_many :daily_revenues
    has_many :monthly_revenues
    belongs_to :provider, optional: true
    
    has_one_attached :image

    validates :name, presence: true
    validates :address, presence: true
    validates :phone_number, presence: true
    validates :city, presence: true
    validates :country, presence: true
    validates :postal_code, presence: true

    validate :phone_number_with_prefix
    
    friendly_id :name, use: :slugged

    attr_accessor :current_password

    def phone_number_with_prefix
        errors.add(:phone_number, "must include an international prefix") unless phone_number =~ /\A\+\d+\d+\z/
    end
end

