class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound do |exception|
    respond_with :not_found, exception
  end

  rescue_from ActiveRecord::RecordInvalid do |exception|
    respond_with :bad_request, exception
  end

  rescue_from Errors::ChildNotFound do |exception|
    respond_with :not_found, exception
  end

  rescue_from Errors::OrderNotCreated do |exception|
    respond_with :unprocessable_entity, exception
  end

  rescue_from Errors::OrderFieldError do |exception|
    respond_with :unprocessable_entity, exception
  end

  private

  def respond_with(status, message)
    render json: { errors: [message] }, status: status  
  end
end
