class ProductsController < ApplicationController
  include Pagy::Backend

  before_action :set_product, only: %i[ show edit update destroy ]

  # GET /products
  def index
    @q = current_user.products.ransack(params[:q])
    @pagy, @products = pagy(@q.result(distinct: true))
  end

  # GET /products/1
  def show
  end

  # GET /products/new
  def new
    @product = current_user.products.build
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  def create
    @product = current_user.products.build(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: "Product was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: "Product was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  def destroy
    @product.destroy!

    respond_to do |format|
      format.html { redirect_to products_path, status: :see_other, notice: "Product was successfully destroyed." }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = current_user.products.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def product_params
    params.expect(product: [
      :visible,
      :featured,
      :code,
      :name,
      :description,
      :price,
      :sale_price,
      :sale_starts_at,
      :sale_ends_at,
      :available_from,
      :available_until,
      category_ids: []
    ])
  end
end
