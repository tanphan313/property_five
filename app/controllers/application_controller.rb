class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound,
    :with => :render_error_notfound

  private
  def render_error_notfound
    render :json => {errors: "Record not found"}, :status => 404
  end
end
