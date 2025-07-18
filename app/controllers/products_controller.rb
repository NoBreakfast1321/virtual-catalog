class ProductsController < ApplicationController
  include Pagy::Backend

  before_action :set_business
  before_action :set_product, only: %i[show edit update destroy]

  before_action :restrict_product_creation, only: %i[new create]

  # GET /businesses/:business_id/products
  def index
    @q = @business.products.ransack(params[:q])
    @pagy, @products = pagy(@q.result(distinct: true))
  end

  # GET /businesses/:business_id/products/:id
  def show
  end

  # GET /businesses/:business_id/products/new
  def new
    @product = @business.products.build
  end

  # GET /businesses/:business_id/products/:id/edit
  def edit
  end

  # POST /businesses/:business_id/products
  def create
    @product = @business.products.build(product_params)

    # Attach newly uploaded images to the product
    if params[:product][:images]
      @product.images.attach(params[:product][:images])
    end

    respond_to do |format|
      begin
        ActiveRecord::Base.transaction do
          @product.save!

          @product.variants.create!(
            base: true,
            code: "#{params[:product][:code]}-BASE",
            price: params[:product][:price],
            visible: params[:product][:visible],
          )
        end

        format.html do
          redirect_to [ @business, @product ],
                      notice: t_controller("create.success")
        end
      rescue ActiveRecord::RecordInvalid => error
        flash.now[:alert] = error.record.errors.full_messages.to_sentence

        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /businesses/:business_id/products/:id
  def update
    # Purge images that were marked for deletion
    if (image_ids = params.dig(:product, :purge_image_ids).presence)
      @product.images.attachments.where(id: image_ids.map(&:to_i)).each(&:purge)
    end

    # Attach newly uploaded images to the product
    if params[:product][:images]
      @product.images.attach(params[:product][:images])
    end

    respond_to do |format|
      begin
        ActiveRecord::Base.transaction do
          @product.update!(product_params)

          @product.base_variant.update!(
            code: params[:product][:code],
            price: params[:product][:price],
            visible: params[:product][:visible],
          )
        end

        format.html do
          redirect_to [ @business, @product ],
                      notice: t_controller("update.success")
        end
      rescue ActiveRecord::RecordInvalid => error
        flash.now[:alert] = error.record.errors.full_messages.to_sentence

        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /businesses/:business_id/products/:id
  def destroy
    respond_to do |format|
      if @product.destroy
        format.html do
          redirect_to business_products_path(@business),
                      notice: t_controller("destroy.success"),
                      status: :see_other
        end
      else
        format.html do
          flash.now[:alert] = @product.errors.full_messages.to_sentence

          render :show, status: :unprocessable_entity
        end
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_business
    @business = current_user.businesses.find(params.expect(:business_id))
  end

  def set_product
    @product = @business.products.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def product_params
    params.expect(
      product: [
        :adult_only,
        :available_from,
        :available_until,
        :code,
        :description,
        :featured,
        :name,
        :visible,
        category_ids: []
      ],
    )
  end

  def restrict_product_creation
    if @business.categories.empty?
      redirect_to new_business_category_path(@business),
                  alert: t_controller("callbacks.restrict_product_creation")
    end
  end
end
