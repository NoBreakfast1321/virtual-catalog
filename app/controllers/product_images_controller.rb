class ProductImagesController < ApplicationController
  before_action :set_catalog
  before_action :set_product

  def update
    ActiveRecord::Base.transaction do
      # Attach newly uploaded images to the product.
      attach_images

      # Purge images that were marked for deletion.
      purge_images
    end

    flash.now[:notice] = t_controller("update.success")
  end

  private

  def attach_images
    images = product_images_params[:images]

    return if images.blank?

    images.each { |image| @product.images.attach(image) }
  end

  def purge_images
    purge_image_ids = product_images_params[:purge_image_ids]

    return if purge_image_ids.blank?

    purge_image_ids.each do |purge_image_id|
      image =
        @product.images.attachments.find do |attachment|
          attachment.id == purge_image_id.to_i
        end

      unless image
        Rails.logger.warn(
          t_controller("logger.not_found", id: purge_image_id),
        )

        flash.now[:alert] = t_controller("toaster.not_found")

        next
      end

      image.purge
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_catalog
    @catalog = current_user.catalogs.find(params.expect(:catalog_id))
  end

  def set_product
    @product = @catalog.products.find(params.expect(:product_id))
  end

  # Only allow a list of trusted parameters through.
  def product_images_params
    params.expect(product: [ images: [], purge_image_ids: [] ])
  end
end
