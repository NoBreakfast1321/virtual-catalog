class LineItemsController < ApplicationController
  skip_before_action :authenticate_user!

  before_action :set_catalog
  before_action :set_customer_token
  before_action :set_customer, if: -> { @customer_token.present? }
  before_action :set_line_item, only: %i[edit update destroy]
  before_action :set_product, if: -> { params[:product_slug].present? }
  before_action :build_line_item_with_params, only: %i[create]
  before_action :build_line_item_without_params, only: %i[new]

  def index
    @line_items = @customer.line_items
  end

  def new
  end

  def edit
  end

  def create
    @line_item.save!

    respond_to do |format|
      format.turbo_stream do
        flash.now[:notice] = t_controller("create.success")
      end
    end
  end

  def update
    @line_item.update!(line_item_params)

    respond_to do |format|
      format.turbo_stream do
        flash.now[:notice] = t_controller("update.success")
      end
    end
  end

  def destroy
    @line_item.destroy!

    respond_to do |format|
      format.turbo_stream do
        flash.now[:notice] = t_controller("destroy.success")
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_catalog
    @catalog = Catalog.find_by!(slug: params.expect(:catalog_slug))
  end

  def set_customer_token
    @customer_token = cookies[:customer_token]
  end

  def set_customer
    @customer = @catalog.customers.find_or_create_by(token: @customer_token)
  end

  def set_line_item
    @line_item = @customer.line_items.find(params.expect(:id))
  end

  def set_product
    @product = @catalog.products.find_by!(slug: params.expect(:product_slug))
  end

  def build_line_item_with_params
    @line_item = @customer.line_items.build(line_item_params)
  end

  def build_line_item_without_params
    @line_item = @customer.line_items.build
  end

  # Only allow a list of trusted parameters through.
  def line_item_params
    params.expect(line_item: %i[variant_id quantity])
  end
end
