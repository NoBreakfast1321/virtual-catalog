class PublicCatalogsController < ApplicationController
  skip_before_action :authenticate_user!

  def show
    @catalog = Catalog.find_by!(slug: params[:slug])
    @categories = @catalog.categories.populated
  end
end
