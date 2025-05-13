require "test_helper"

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    sign_in @user
    @category = categories(:one)
  end

  test "should get index" do
    get categories_url
    assert_response :success
  end

  test "should show category" do
    get category_url(@category)
    assert_response :success
  end

  test "should get new" do
    get new_category_url
    assert_response :success
  end

  test "should get edit" do
    get edit_category_url(@category)
    assert_response :success
  end

  test "should create category" do
    assert_difference("Category.count") do
      post categories_url, params: { category: { visible: @category.visible?, name: "Name", description: @category.description } }
    end

    assert_redirected_to category_url(Category.last)
  end

  test "should update category via PATCH" do
    patch category_url(@category), params: { category: { visible: @category.visible?, name: @category.name, description: @category.description } }
    assert_redirected_to category_url(@category)
  end

  test "should update category via PUT" do
    put category_url(@category), params: { category: { visible: @category.visible?, name: @category.name, description: @category.description } }
    assert_redirected_to category_url(@category)
  end

  test "should destroy category" do
    assert_difference("Category.count", -1) do
      delete category_url(@category)
    end

    assert_redirected_to categories_url
  end
end
