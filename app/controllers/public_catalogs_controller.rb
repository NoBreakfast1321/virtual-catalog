class PublicCatalogsController < ApplicationController
  layout "public_application"

  skip_before_action :authenticate_user!

  before_action :set_catalog
  before_action :set_customer_token
  before_action :set_customer, if: -> { @customer_token.present? }
  before_action :set_categories

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

  def set_categories
    @categories = @catalog.categories.populated
  end
end
