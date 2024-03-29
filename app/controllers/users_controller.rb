class UsersController < ApplicationController
  before_action :set_user, only: %i[show update destroy]

  def index
    @users = User.all
  end

  def update 
    if @user.update(user_params)
      render :show, status: 200
    else
      render json: @user.errors.messages, status: 422
    end
  end

  def destroy
    if @user.destroy
      head :ok
    else
      render json: @user.errors.messages, status: 422
    end
  end

  def set_user
    @user = User.find(params[:id])
  end
  
  private
  def user_params
      params.permit(:name, :email, :biography, :password)
  end
end
