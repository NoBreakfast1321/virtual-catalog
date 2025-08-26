class PublicProductsController < ApplicationController
  layout "public_application"

  skip_before_action :authenticate_user!

  def show
    @catalog = Catalog.find_by!(slug: params[:catalog_slug])
    @product = @catalog.products.find_by!(slug: params[:slug])
  end
end
