class PublicProductsController < ApplicationController
  layout "public_application"

  skip_before_action :authenticate_user!

  def show
    @catalog = Catalog.friendly.find(params[:catalog_slug])
    @product = @catalog.products.friendly.find(params[:product_slug])
  end
end
