class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from Aws::Sigv4::Errors::MissingCredentialsError, with: :auth_error_aws

  def auth_error_aws
    render json: { error: 'Access denied! Try again changing AWS credentials.' }, status: 401
  end

  def record_not_found(error)
    render json: { not_found: error.message }, status: :not_found
  end
end
