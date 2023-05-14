class Restaurant < ApplicationRecord
    extend FriendlyId
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
    
    has_many :food_items, dependent: :destroy
    has_many :tables, dependent: :destroy
    
    friendly_id :name, use: :slugged
end
