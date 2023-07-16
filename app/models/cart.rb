class Cart < ApplicationRecord
  belongs_to :restaurant
  has_many :cart_items, dependent: :destroy
  has_many :cart_item_food_items, through: :cart_items

  def add_food_item(food_item_id)
    food_item = FoodItem.find_by(id: food_item_id)
    if food_item.present?
      cart_item = cart_items.build
      cart_item.cart_item_food_items.build(food_item: food_item)
    end
    cart_item
  end

  def add_special_menu(special_menu_id, food_item_ids)
    special_menu = SpecialMenu.find_by(id: special_menu_id)
    if special_menu.present?
      cart_item = cart_items.build(special_menu: special_menu)
      if food_item_ids.present?
        food_item_ids.each do |food_type_id, food_item_id|
          food_type = FoodType.find_by(id: food_type_id)
          food_item = food_type.food_items.find_by(id: food_item_id)
          if food_item.present?
            cart_item.cart_item_food_items.build(food_item: food_item, cart_item: @cart_item)
            SpecialMenuFoodItem.create(special_menu: special_menu, food_item: food_item)  # Create a SpecialMenuFoodItem record to establish the association
          end
        end
      end
    end
    cart_item
  end
  
  
  def total_price
    total_price = 0

    cart_items.each do |cart_item|
      if cart_item.special_menu.present?
        total_price += cart_item.special_menu.price
      elsif cart_item.food_items.present?
        cart_item.food_items.each do |food_item| 
          total_price += food_item.price
        end
      end
    end
    total_price
  end


end
