class PublicCatalogsController < ApplicationController
  layout "public_application"

  skip_before_action :authenticate_user!

  def show
    @catalog = Catalog.friendly.find(params[:catalog_slug])
    @categories = @catalog.categories.populated
  end
end
