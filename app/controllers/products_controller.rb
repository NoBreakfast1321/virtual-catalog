class ProductsController < ApplicationController
  include Pagy::Backend

  before_action :set_product, only: %i[ show edit update destroy ]
  before_action :restrict_product_creation, only: %i[ new create ]

  # GET /products
  def index
    @q = current_business.products.ransack(params[:q])
    @pagy, @products = pagy(@q.result(distinct: true))
  end

  # GET /products/new
  def new
    @product = current_business.products.build
  end

  # GET /products/:id
  def show
  end

  # GET /products/:id/edit
  def edit
  end

  # POST /products
  def create
    @product = current_business.products.build(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: "Product was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/:id
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: "Product was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/:id
  def destroy
    respond_to do |format|
      if @product.destroy
        format.html { redirect_to categories_path, status: :see_other, notice: "Product was successfully destroyed." }
      else
        format.html do
          flash.now[:alert] = @product.errors.full_messages.to_sentence
          render :show, status: :unprocessable_entity
        end
      end
    end
  end

  private

  def restrict_product_creation
    if current_business.categories.empty?
      redirect_to new_category_path, alert: "You must create at least one category before creating a product."
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = current_business.products.find(params.expect(:id))
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
