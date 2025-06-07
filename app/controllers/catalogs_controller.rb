class CatalogsController < ApplicationController
  skip_before_action :authenticate_user!

  def show
    @business = Business.find_by!(slug: params[:slug])
    @categories = @business.categories.includes(:products)
  end
end
