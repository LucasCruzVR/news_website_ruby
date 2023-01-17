class AuthenticationController < ApplicationController
    skip_before_action :authenticate_user
    include Jwt
    
    def login
        @user = User.find_by_email(params[:email])
        if @user&.authenticate(params[:password])
            @time = Time.now + 24.hours.to_i
            @token = jwt_encode(user_id: @user.id, exp: @time)
            render :show, status: :ok
        else
            render json: { error: 'Unauthorized' }, status: :unauthorized
        end
    end

    def sign_up
        @user = User.new(auth_params)
        byebug
        if @user.save
            @time = Time.now + 24.hours.to_i
            @token = jwt_encode(user_id: @user.id, exp: @time)
            render :show, status: :created
        else
            render json: @user.errors.messages, status: 422
        end
    end

    private
    def auth_params
        params.permit(:name, :email, :biography, :password)
    end
end