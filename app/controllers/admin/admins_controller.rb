module Admin
  class AdminsController < Admin::ApplicationController
    FORM_PARAMS = %i(name email password).freeze

    def index
      setup_list_admins
    end

    def show
      render :show, status: :ok
    end

    def create
      @admin = Admin.new
      if admin.save form_params
        render :create, status: :created
      else
        render json: {errors: admin.errors.full_messages}, status: :unprocessable_entity
      end
    end

    def update
      if admin.update form_params
        render :update, status: :created
      else
        render json: {errors: admin.errors.full_messages}, status: :unprocessable_entity
      end
    end

    def destroy
      return render json: {errors: "Can not delete the current admin"}, status: :unprocessable_entity if current_admin.id == params[:id].to_i
      if admin.destroy
        setup_list_admins
        render :index, status: :created
      else
        render json: {errors: admin.errors.full_messages}, status: :unprocessable_entity
      end
    end

    private
    def search_params
      SearchParams.(params.fetch(:q, {}), RANSACK_MAP_KEYS)
    end

    def form_params
      params.require(:admin).permit(FORM_PARAMS)
    end

    def setup_list_admins
      @admins = Admin.ransack(search_params).result.newest.page(params[:page])
      @presenters = @admins.map {|admin| AdminPresenter.new(admin)}
    end

    def admin
      @admin ||= Admin.find(params[:id])
    end
    helper_method :admin
  end
end
