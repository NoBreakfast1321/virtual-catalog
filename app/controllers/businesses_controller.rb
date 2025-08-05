class BusinessesController < ApplicationController
  include Pagy::Backend

  before_action :set_business, only: %i[show edit update destroy]
  before_action :set_business_with_params, only: %i[create]

  # GET /businesses
  def index
    @q = current_user.businesses.ransack(params[:q])
    @pagy, @businesses = pagy(@q.result(distinct: true))
  end

  # GET /businesses/:id
  def show
  end

  # GET /businesses/new
  def new
    @business = current_user.businesses.build
  end

  # GET /businesses/:id/edit
  def edit
  end

  # POST /businesses
  def create
    @business.save!

    respond_to do |format|
      format.html do
        redirect_to @business, notice: t_controller("create.success")
      end
    end
  end

  # PATCH/PUT /businesses/:id
  def update
    @business.update!(business_params)

    respond_to do |format|
      format.html do
        redirect_to @business, notice: t_controller("update.success")
      end
    end
  end

  # DELETE /businesses/:id
  def destroy
    @business.destroy!

    respond_to do |format|
      format.html do
        redirect_to businesses_path,
                    notice: t_controller("destroy.success"),
                    status: :see_other
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_business
    @business = current_user.businesses.find(params.expect(:id))
  end

  def set_business_with_params
    @business = current_user.businesses.build(business_params)
  end

  # Only allow a list of trusted parameters through.
  def business_params
    params.expect(business: %i[description name slug visible])
  end
end
