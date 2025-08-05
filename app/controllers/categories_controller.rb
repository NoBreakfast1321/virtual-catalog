class CategoriesController < ApplicationController
  include Pagy::Backend

  before_action :set_business
  before_action :set_category, only: %i[show edit update destroy]
  before_action :set_category_with_params, only: %i[create]

  # GET /businesses/:business_id/categories
  def index
    @q = @business.categories.ransack(params[:q])
    @pagy, @categories = pagy(@q.result(distinct: true))
  end

  # GET /businesses/:business_id/categories/:id
  def show
  end

  # GET /businesses/:business_id/categories/new
  def new
    @category = @business.categories.build
  end

  # GET /businesses/:business_id/categories/:id/edit
  def edit
  end

  # POST /businesses/:business_id/categories
  def create
    @category.save!

    respond_to do |format|
      format.html do
        redirect_to [ @business, @category ],
                    notice: t_controller("create.success")
      end
    end
  end

  # PATCH/PUT /businesses/:business_id/categories/:id
  def update
    @category.update!(category_params)

    respond_to do |format|
      format.html do
        redirect_to [ @business, @category ],
                    notice: t_controller("update.success")
      end
    end

    # DELETE /businesses/:business_id/categories/:id
    def destroy
      @category.destroy!

      respond_to do |format|
        format.html do
          redirect_to business_categories_path(@business),
                      notice: t_controller("destroy.success"),
                      status: :see_other
        end
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_business
    @business = current_user.businesses.find(params.expect(:business_id))
  end

  def set_category
    @category = @business.categories.find(params.expect(:id))
  end

  def set_category_with_params
    @category = @business.categories.build(category_params)
  end

  # Only allow a list of trusted parameters through.
  def category_params
    params.expect(category: %i[description name visible])
  end
end
