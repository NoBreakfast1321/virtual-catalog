class ProductsController < ApplicationController
  include Pagy::Backend

  before_action :set_business
  before_action :set_product, only: %i[ show edit update destroy ]

  before_action :restrict_product_creation, only: %i[ new create ]

  # GET /businesses/:business_id/products
  def index
    @q = @business.products.ransack(params[:q])
    @pagy, @products = pagy(@q.result(distinct: true))
  end

  # GET /businesses/:business_id/products/new
  def new
    @product = @business.products.build
  end

  # GET /businesses/:business_id/products/:id
  def show
  end

  # GET /businesses/:business_id/products/:id/edit
  def edit
  end

  # POST /businesses/:business_id/products
  def create
    @product = @business.products.build(product_params)

    @product.images.attach(params[:product][:images]) if params[:product][:images]

    respond_to do |format|
      begin
        ActiveRecord::Base.transaction do
          @product.save!

          @product.variants.create!(
            base: true,
            code: "#{params[:product][:code]}-BASE",
            price: params[:product][:price]
          )
        end

        format.html { redirect_to [ @business, @product ], notice: "Product was successfully created." }
      rescue ActiveRecord::RecordInvalid => error
        flash.now[:alert] = error.record.errors.full_messages.to_sentence

        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /businesses/:business_id/products/:id
  def update
    if (image_ids = params.dig(:product, :purge_image_ids).presence)
      @product.images.attachments.where(id: image_ids.map(&:to_i)).each(&:purge)
    end

    @product.images.attach(params[:product][:images]) if params[:product][:images]

    respond_to do |format|
      begin
        ActiveRecord::Base.transaction do
          @product.update!(product_params)

          @product.base_variant&.update!(
            code: params[:product][:code],
            price: params[:product][:price]
          )
        end

        format.html { redirect_to [ @business, @product ], notice: "Product was successfully updated." }
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
        format.html { redirect_to business_products_path(@business), status: :see_other, notice: "Product was successfully destroyed." }
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
    params.expect(product: [
      :available_from,
      :available_until,
      :code,
      :description,
      :featured,
      :name,
      :visible,
      category_ids: []
    ])
  end

  def restrict_product_creation
    redirect_to new_business_category_path(@business), alert: "You must create at least one category before creating a product." if @business.categories.empty?
  end
end
