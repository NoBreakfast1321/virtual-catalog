class PublicProductsController < ApplicationController
  skip_before_action :authenticate_user!

  def show
    @business = Business.find_by!(slug: params[:business_slug])
    @product = @business.products.find_by!(slug: params[:slug])
  end
end
