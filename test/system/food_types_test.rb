require "application_system_test_case"

class FoodTypesTest < ApplicationSystemTestCase
  setup do
    @food_type = food_types(:one)
  end

  test "visiting the index" do
    visit food_types_url
    assert_selector "h1", text: "Food Types"
  end

  test "creating a Food type" do
    visit food_types_url
    click_on "New Food Type"

    fill_in "Name", with: @food_type.name
    fill_in "Special menu", with: @food_type.special_menu_id
    click_on "Create Food type"

    assert_text "Food type was successfully created"
    click_on "Back"
  end

  test "updating a Food type" do
    visit food_types_url
    click_on "Edit", match: :first

    fill_in "Name", with: @food_type.name
    fill_in "Special menu", with: @food_type.special_menu_id
    click_on "Update Food type"

    assert_text "Food type was successfully updated"
    click_on "Back"
  end

  test "destroying a Food type" do
    visit food_types_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Food type was successfully destroyed"
  end
end
