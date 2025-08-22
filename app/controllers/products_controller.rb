class ProductsController < ApplicationController
  include Pagy::Backend

  before_action :set_catalog
  before_action :set_product, only: %i[show edit update destroy]
  before_action :build_product_with_params, only: %i[create]
  before_action :build_product_without_params, only: %i[new]

  before_action :restrict_product_creation, only: %i[new create]

  def index
    @q = @catalog.products.ransack(params[:q])
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
        code: "#{params[:product][:code]}-BASE",
        price: params[:product][:price],
        base: true,
        visible: params[:product][:visible],
      )
    end

    respond_to do |format|
      format.html do
        redirect_to [ @catalog, @product ],
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
        redirect_to [ @catalog, @product ],
                    notice: t_controller("update.success")
      end
    end
  end

  def destroy
    @product.destroy!

    respond_to do |format|
      format.html do
        redirect_to catalog_products_path(@catalog),
                    notice: t_controller("destroy.success"),
                    status: :see_other
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_catalog
    @catalog = current_user.catalogs.find(params.expect(:catalog_id))
  end

  def set_product
    @product = @catalog.products.find(params.expect(:id))
  end

  def build_product_with_params
    @product = @catalog.products.build(product_params)
  end

  def build_product_without_params
    @product = @catalog.products.build
  end

  # Only allow a list of trusted parameters through.
  def product_params
    params.expect(
      product: [
        :name,
        :code,
        :description,
        :adult_only,
        :featured,
        :visible,
        :available_from,
        :available_until,
        category_ids: []
      ],
    )
  end

  def restrict_product_creation
    unless @catalog.categories.any?
      redirect_to new_catalog_category_path(@catalog),
                  alert: t_controller("callbacks.restrict_product_creation")
    end
  end
end
