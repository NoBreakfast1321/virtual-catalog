class PublicProductsController < ApplicationController
  layout "public_application"

  skip_before_action :authenticate_user!

  before_action :set_catalog
  before_action :set_customer_token
  before_action :set_customer, if: -> { @customer_token.present? }
  before_action :set_line_item
  before_action :set_product

  def show
  end

  private

  def set_catalog
    @catalog = Catalog.find_by!(slug: params.expect(:catalog_slug))
  end

  def set_customer_token
    @customer_token = cookies[:customer_token]
  end

  def set_customer
    @customer = @catalog.customers.find_or_create_by(token: @customer_token)
  end

  def set_product
    @product = @catalog.products.find_by!(slug: params.expect(:product_slug))
  end

  def set_line_item
    @line_item =
      @customer.line_items.find(params[:line_item_id]) if @customer.present? &&
      params[:line_item_id].present?
  end
end
