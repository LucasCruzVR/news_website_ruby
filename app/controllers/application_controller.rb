class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from Aws::Sigv4::Errors::MissingCredentialsError, with: :auth_error_aws
  include Jwt

  def auth_error_aws
    render json: { error: 'Access denied! Try again changing AWS credentials.' }, status: 401
  end

  def record_not_found(error)
    render json: { not_found: error.message }, status: :not_found
  end

    

  private
  def authenticate_user
      header = request.headers['Authorization']
      header = header.split(' ').last if header
      begin
          @decoded = jwt_decode(header)
          @current_user = User.find(@decoded[:user_id])
      rescue ActiveRecord::RecordNotFound => e
          render json: { errors: e.message }, status: :unauthorized
      rescue JWT::DecodeError => e
          render json: { erros: e.message }, status: :unauthorized
      end
  end
end
