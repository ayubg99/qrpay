require 'test_helper'

class SpecialMenusControllerTest < ActionDispatch::IntegrationTest
  setup do
    @special_menu = special_menus(:one)
  end

  test "should get index" do
    get special_menus_url
    assert_response :success
  end

  test "should get new" do
    get new_special_menu_url
    assert_response :success
  end

  test "should create special_menu" do
    assert_difference('SpecialMenu.count') do
      post special_menus_url, params: { special_menu: { name: @special_menu.name, restaurant_id: @special_menu.restaurant_id } }
    end

    assert_redirected_to special_menu_url(SpecialMenu.last)
  end

  test "should show special_menu" do
    get special_menu_url(@special_menu)
    assert_response :success
  end

  test "should get edit" do
    get edit_special_menu_url(@special_menu)
    assert_response :success
  end

  test "should update special_menu" do
    patch special_menu_url(@special_menu), params: { special_menu: { name: @special_menu.name, restaurant_id: @special_menu.restaurant_id } }
    assert_redirected_to special_menu_url(@special_menu)
  end

  test "should destroy special_menu" do
    assert_difference('SpecialMenu.count', -1) do
      delete special_menu_url(@special_menu)
    end

    assert_redirected_to special_menus_url
  end
end
