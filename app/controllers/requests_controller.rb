class RequestsController < ApplicationController
  FROM_PARAMS = %i(name phone_number email address property_type property_age acreage land_acreage note agree)

  def create
    @request = Request.new form_params
    if @request.save
      render json: {message: "Request created"}, status: :created
    else
      render json: {errors: @request.errors.full_messages}, status: :unprocessable_entity
    end
  end

  private
  def form_params
    params.require(:request).permit(FORM_PARAMS)
  end
end
