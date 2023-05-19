require "application_system_test_case"

class SpecialMenusTest < ApplicationSystemTestCase
  setup do
    @special_menu = special_menus(:one)
  end

  test "visiting the index" do
    visit special_menus_url
    assert_selector "h1", text: "Special Menus"
  end

  test "creating a Special menu" do
    visit special_menus_url
    click_on "New Special Menu"

    fill_in "Name", with: @special_menu.name
    fill_in "Restaurant", with: @special_menu.restaurant_id
    click_on "Create Special menu"

    assert_text "Special menu was successfully created"
    click_on "Back"
  end

  test "updating a Special menu" do
    visit special_menus_url
    click_on "Edit", match: :first

    fill_in "Name", with: @special_menu.name
    fill_in "Restaurant", with: @special_menu.restaurant_id
    click_on "Update Special menu"

    assert_text "Special menu was successfully updated"
    click_on "Back"
  end

  test "destroying a Special menu" do
    visit special_menus_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Special menu was successfully destroyed"
  end
end
