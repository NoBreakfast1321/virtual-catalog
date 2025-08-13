class ProductImagesController < ApplicationController
  before_action :set_business
  before_action :set_product

  def update
    # Attach newly uploaded images to the product.
    if params[:product][:images]
      @product.images.attach(params[:product][:images])
    end

    # Purge images that were marked for deletion.
    if (image_ids = params.dig(:product, :purge_image_ids).presence)
      @product.images.attachments.where(id: image_ids.map(&:to_i)).each(&:purge)
    end

    respond_to do |format|
      format.turbo_stream do
        flash.now[:notice] = t_controller("update.success")
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_business
    @business = current_user.businesses.find(params.expect(:business_id))
  end

  def set_product
    @product = @business.products.find(params.expect(:product_id))
  end
end
