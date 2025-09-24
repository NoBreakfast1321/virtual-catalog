class CustomersController < ApplicationController
  include Pagy::Backend

  before_action :set_catalog
  before_action :set_customer, only: %i[show edit update destroy]

  def index
    @q = @catalog.customers.ransack(params[:q])
    @pagy, @customers = pagy(@q.result(distinct: true))
  end

  def show
  end

  def new
    @customer = @catalog.customers.build
  end

  def edit
  end

  def create
    @customer = @catalog.customers.build(customer_params)

    @customer.save!

    redirect_to [ @catalog, @customer ], notice: t_controller("create.success")
  end

  def update
    @customer.update!(customer_params)

    redirect_to [ @catalog, @customer ], notice: t_controller("update.success")
  end

  def destroy
    @customer.destroy!
    redirect_to catalog_customers_path(@catalog),
                notice: t_controller("destroy.success"),
                status: :see_other
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_catalog
    @catalog = current_user.catalogs.find(params.expect(:catalog_id))
  end

  def set_customer
    @customer = @catalog.customers.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def customer_params
    params.expect(customer: %i[email phone name])
  end
end
