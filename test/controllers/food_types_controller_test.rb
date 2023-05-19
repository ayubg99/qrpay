require 'test_helper'

class FoodTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @food_type = food_types(:one)
  end

  test "should get index" do
    get food_types_url
    assert_response :success
  end

  test "should get new" do
    get new_food_type_url
    assert_response :success
  end

  test "should create food_type" do
    assert_difference('FoodType.count') do
      post food_types_url, params: { food_type: { name: @food_type.name, special_menu_id: @food_type.special_menu_id } }
    end

    assert_redirected_to food_type_url(FoodType.last)
  end

  test "should show food_type" do
    get food_type_url(@food_type)
    assert_response :success
  end

  test "should get edit" do
    get edit_food_type_url(@food_type)
    assert_response :success
  end

  test "should update food_type" do
    patch food_type_url(@food_type), params: { food_type: { name: @food_type.name, special_menu_id: @food_type.special_menu_id } }
    assert_redirected_to food_type_url(@food_type)
  end

  test "should destroy food_type" do
    assert_difference('FoodType.count', -1) do
      delete food_type_url(@food_type)
    end

    assert_redirected_to food_types_url
  end
end
