require "application_system_test_case"

class CategoriesTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    sign_in @user
    @category = categories(:one)
  end

  test "visiting the index" do
    visit categories_url
    assert_selector "h1", text: "Categories"
  end

  test "should create category" do
    visit categories_url
    click_on "New category"
    check "Visible" if @category.visible?
    fill_in "Name", with: "Name"
    fill_in "Description", with: @category.description
    click_on "Create Category"
    assert_text "Category was successfully created."
  end

  test "should update category" do
    visit category_url(@category)
    click_on "Edit this category"
    check "Visible" if @category.visible?
    fill_in "Name", with: @category.name
    fill_in "Description", with: @category.description
    click_on "Update Category"
    assert_text "Category was successfully updated."
  end

  test "should destroy category" do
    visit category_url(@category)
    click_on "Destroy this category"
    assert_text "Category was successfully destroyed."
  end
end
