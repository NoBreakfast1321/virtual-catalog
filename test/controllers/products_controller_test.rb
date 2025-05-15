require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    sign_in @user
    @product = products(:one)
  end

  test "should get index" do
    get products_url
    assert_response :success
  end

  test "should show product" do
    get product_url(@product)
    assert_response :success
  end

  test "should get new" do
    get new_product_url
    assert_response :success
  end

  test "should get edit" do
    get edit_product_url(@product)
    assert_response :success
  end

  test "should create product" do
    assert_difference("Product.count") do
      post product_url(@product), params: {
        product: {
          visible: @product.visible?,
          featured: @product.featured?,
          code: @product.code,
          name: "Name",
          description: @product.description,
          price: @product.price,
          sale_price: @product.sale_price,
          sale_starts_at: @product.sale_starts_at,
          sale_ends_at: @product.sale_ends_at,
          available_from: @product.available_from,
          available_until: @product.available_until
        }
      }
    end

    assert_redirected_to product_url(Product.last)
  end

  test "should update product via PATCH" do
    patch product_url(@product), params: {
      product: {
        visible: @product.visible?,
        featured: @product.featured?,
        code: @product.code,
        name: @product.name,
        description: @product.description,
        price: @product.price,
        sale_price: @product.sale_price,
        sale_starts_at: @product.sale_starts_at,
        sale_ends_at: @product.sale_ends_at,
        available_from: @product.available_from,
        available_until: @product.available_until
      }
    }

    assert_redirected_to product_url(@product)
  end

  test "should update product via PUT" do
    put product_url(@product), params: {
      product: {
        visible: @product.visible?,
        featured: @product.featured?,
        code: @product.code,
        name: @product.name,
        description: @product.description,
        price: @product.price,
        sale_price: @product.sale_price,
        sale_starts_at: @product.sale_starts_at,
        sale_ends_at: @product.sale_ends_at,
        available_from: @product.available_from,
        available_until: @product.available_until
      }
    }

    assert_redirected_to product_url(@product)
  end

  test "should destroy product" do
    assert_difference("Product.count", -1) do
      delete product_url(@product)
    end

    assert_redirected_to products_url
  end
end
