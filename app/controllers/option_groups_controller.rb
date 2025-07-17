class OptionGroupsController < ApplicationController
  include Pagy::Backend

  before_action :set_business
  before_action :set_option_group, only: %i[show edit update destroy]

  # GET /businesses/:business_id/option_groups
  def index
    @q = @business.option_groups.ransack(params[:q])
    @pagy, @option_groups = pagy(@q.result(distinct: true))
  end

  # GET /businesses/:business_id/option_groups/:id
  def show
  end

  # GET /businesses/:business_id/option_groups/new
  def new
    @option_group = @business.option_groups.build
  end

  # GET /businesses/:business_id/option_groups/:id/edit
  def edit
  end

  # POST /businesses/:business_id/option_groups
  def create
    @option_group = @business.option_groups.build(option_group_params)

    respond_to do |format|
      if @option_group.save
        format.html do
          redirect_to [ @business, @option_group ],
                      notice: t_controller("create.success")
        end
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /businesses/:business_id/option_groups/:id
  def update
    respond_to do |format|
      if @option_group.update(option_group_params)
        format.html do
          redirect_to [ @business, @option_group ],
                      notice: t_controller("update.success")
        end
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /businesses/:business_id/option_groups/:id
  def destroy
    respond_to do |format|
      if @option_group.destroy
        format.html do
          redirect_to business_option_groups_path(@business),
                      notice: t_controller("destroy.success"),
                      status: :see_other
        end
      else
        format.html do
          flash.now[:alert] = @option_group.errors.full_messages.to_sentence

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

  def set_option_group
    @option_group = @business.option_groups.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def option_group_params
    params.expect(option_group: %i[maximum_selections minimum_selections name])
  end
end
