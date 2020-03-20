module AdminApi
  class CreatorsController < AdminApi::ApplicationController
    RANSACK_MAP_KEYS = {
      name: :name_cont,
      any_text: :name_or_email_cont
    }
    FORM_PARAMS = [:name, :email, :password].freeze

    def index
      @creators = Creator.ransack(search_params).result.newest.page(params[:page]).per(params[:per_page])
    end

    def show
      render :show, status: :ok
    end

    def create
      @creator = Creator.new form_params
      if @creator.save
        render :create, status: :created
      else
        render json: {errors: @creator.errors.full_messages}, status: :unprocessable_entity
      end
    end

    def update
      if creator.update form_params
        render :update, status: :created
      else
        render json: {errors: creator.errors.full_messages}, status: :unprocessable_entity
      end
    end

    def destroy
      if creator.destroy
        render json: {message: "Creator deleted"}, status: :created
      else
        render json: {errors: creator.errors.full_messages}, status: :unprocessable_entity
      end
    end

    private
    def search_params
      SearchParams.(params.fetch(:q, {}), RANSACK_MAP_KEYS)
    end

    def form_params
      @form_params ||= params.require(:creator).permit(FORM_PARAMS).tap do |p|
        p[:password] = nil unless p[:password].present?
      end
    end

    def creator
      @creator ||= Creator.find(params[:id])
    end
    helper_method :creator
  end
end
