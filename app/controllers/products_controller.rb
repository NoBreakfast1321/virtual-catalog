class ProductsController < ApplicationController
  include Pagy::Backend

  before_action :set_business
  before_action :set_product, only: %i[show edit update destroy]
  before_action :build_product_with_params, only: %i[create]
  before_action :build_product_without_params, only: %i[new]

  before_action :restrict_product_creation, only: %i[new create]

  def index
    @q = @business.products.ransack(params[:q])
    @pagy, @products = pagy(@q.result(distinct: true))
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    ActiveRecord::Base.transaction do
      @product.save!

      @product.variants.create!(
        base: true,
        code: "#{params[:product][:code]}-BASE",
        price: params[:product][:price],
        visible: params[:product][:visible],
      )
    end

    respond_to do |format|
      format.html do
        redirect_to [ @business, @product ],
                    notice: t_controller("create.success")
      end
    end
  end

  def update
    ActiveRecord::Base.transaction do
      @product.update!(product_params)

      @product.base_variant.update!(
        code: params[:product][:code],
        price: params[:product][:price],
        visible: params[:product][:visible],
      )
    end

    respond_to do |format|
      format.html do
        redirect_to [ @business, @product ],
                    notice: t_controller("update.success")
      end
    end
  end

  def destroy
    @product.destroy!

    respond_to do |format|
      format.html do
        redirect_to business_products_path(@business),
                    notice: t_controller("destroy.success"),
                    status: :see_other
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

  def build_product_with_params
    @product = @business.products.build(product_params)
  end

  def build_product_without_params
    @product = @business.products.build
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
