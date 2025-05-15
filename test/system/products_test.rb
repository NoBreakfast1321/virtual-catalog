require "application_system_test_case"

class ProductsTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    sign_in @user
    @product = products(:one)
  end

  test "visiting the index" do
    visit products_url
    assert_selector "h1", text: "Products"
  end

  test "should create product" do
    visit products_url
    click_on "New product"
    fill_in "Code", with: "Code"
    fill_in "Name", with: "Name"
    fill_in "Description", with: @product.description
    fill_in "Price", with: @product.price
    fill_in "Sale price", with: @product.sale_price
    fill_in "Sale starts at", with: @product.sale_starts_at.to_s
    fill_in "Sale ends at", with: @product.sale_ends_at.to_s
    fill_in "Available from", with: @product.available_from.to_s
    fill_in "Available until", with: @product.available_until.to_s
    click_on "Create Product"
    assert_text "Product was successfully created."
  end

  test "should update product" do
    visit product_url(@product)
    click_on "Edit this product"
    check "Visible" if @product.visible?
    check "Featured" if @product.featured?
    fill_in "Code", with: @product.code
    fill_in "Name", with: @product.name
    fill_in "Description", with: @product.description
    fill_in "Price", with: @product.price
    fill_in "Sale price", with: @product.sale_price
    fill_in "Sale starts at", with: @product.sale_starts_at.to_s
    fill_in "Sale ends at", with: @product.sale_ends_at.to_s
    fill_in "Available from", with: @product.available_from.to_s
    fill_in "Available until", with: @product.available_until.to_s
    click_on "Update Product"
    assert_text "Product was successfully updated."
  end

  test "should destroy product" do
    visit product_url(@product)
    click_on "Destroy this product"
    assert_text "Product was successfully destroyed."
  end
end
