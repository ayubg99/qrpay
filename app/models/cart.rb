class Cart < ApplicationRecord
  belongs_to :restaurant
  has_many :cart_items, dependent: :destroy
  has_many :cart_item_food_items, through: :cart_items

  def add_food_item(food_item_id)
    food_item = FoodItem.find_by(id: food_item_id)
    if food_item.present?
      cart_item = cart_items.find_by(food_item_id: food_item_id)
      if cart_item.present?
        cart_item.quantity += 1
      else 
        cart_item = cart_items.build(quantity: 1, food_item_id: food_item_id)
        cart_item.cart_item_food_items.build(food_item: food_item)
      end
    end
    cart_item
  end

  def add_special_menu(special_menu_id, food_item_ids)
    special_menu = SpecialMenu.find_by(id: special_menu_id)
    return unless special_menu.present?
  
    cart_items_with_same_menu = cart_items.where(special_menu_id: special_menu_id)
  
    if cart_items_with_same_menu.present?
      matching_cart_item = cart_items_with_same_menu.find do |cart_item|
        cart_item.cart_item_food_items.map(&:food_item_id).sort == food_item_ids.values.map(&:to_i).sort
      end
  
      if matching_cart_item.present?
        # If a cart_item with the same special_menu_id and the same food_item_ids exists, increment the quantity
        matching_cart_item.quantity += 1
        matching_cart_item.save
        return matching_cart_item
      end
    end
  
    # If no matching cart_item is found, create a new one
    cart_item = cart_items.build(quantity: 1, special_menu_id: special_menu_id)
  
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
    cart_item
  end


  def remove_food(food_item_id)
    current_item = cart_items.find_by(food_item_id: food_item_id)
    if current_item.present?
      if current_item.quantity > 1
        current_item.quantity -= 1
      elsif current_item.quantity == 1
        current_item.destroy
      end
    end
    current_item
  end

  def remove_special_menu(cart_item_id)
    current_item = cart_items.find_by(id: cart_item_id)
    if current_item.present?
      if current_item.quantity > 1
        current_item.quantity -= 1
      elsif current_item.quantity == 1
        current_item.destroy
      end
    end
    current_item
  end  
  
  def total_price
    total_price = 0

    cart_items.each do |cart_item|
      if cart_item.special_menu.present?
        total_price += cart_item.special_menu.price * cart_item.quantity
      elsif cart_item.food_items.present?
        cart_item.food_items.each do |food_item| 
          total_price += food_item.price * cart_item.quantity
        end
      end
    end
    total_price
  end

  def cart_items_count
    cart_items.sum(:quantity)
  end
end
