class OptionGroupsController < ApplicationController
  include Pagy::Backend

  before_action :set_business
  before_action :set_option_group, only: %i[show edit update destroy]
  before_action :build_option_group_with_params, only: %i[create]
  before_action :build_option_group_without_params, only: %i[new]

  def index
    @q = @business.option_groups.ransack(params[:q])
    @pagy, @option_groups = pagy(@q.result(distinct: true))
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    @option_group.save!

    respond_to do |format|
      format.html do
        redirect_to [ @business, @option_group ],
                    notice: t_controller("create.success")
      end
    end
  end

  def update
    @option_group.update!(option_group_params)

    respond_to do |format|
      format.html do
        redirect_to [ @business, @option_group ],
                    notice: t_controller("update.success")
      end
    end
  end

  def destroy
    @option_group.destroy!

    respond_to do |format|
      format.html do
        redirect_to business_option_groups_path(@business),
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

  def set_option_group
    @option_group = @business.option_groups.find(params.expect(:id))
  end

  def build_option_group_with_params
    @option_group = @business.option_groups.build(option_group_params)
  end

  def build_option_group_without_params
    @option_group = @business.option_groups.build
  end

  # Only allow a list of trusted parameters through.
  def option_group_params
    params.expect(
      option_group: %i[name minimum_selections maximum_selections visible],
    )
  end
end
