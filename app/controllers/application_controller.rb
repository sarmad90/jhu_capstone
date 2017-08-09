class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from Mongoid::Errors::DocumentNotFound, with: :record_not_found

  def default_format_json
    request.format = "json"
  end

  protected
    def record_not_found(exception)
      payload = {
        errors: { full_messages: ["cannot find id[#{params[:id]}]"] }
      }
      render json: payload, status: :not_found
      Rails.logger.debug exception.message
    end

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    end
end
