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
    
    friendly_id :name, use: :slugged

    attr_accessor :current_password
end
