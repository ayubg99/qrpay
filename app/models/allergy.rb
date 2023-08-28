class Allergy < ApplicationRecord
    has_and_belongs_to_many :food_items, join_table: :food_item_allergies
end