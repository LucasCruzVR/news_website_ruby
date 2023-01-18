class RolesController < ApplicationController
    before_action :set_role, only: %i[show update destroy]

    def index
        @roles = Role.all
    end

    def show; end

    def create
        @role = Role.new(role_params)
        if @role.save
            render :show, status: :created
        else
            render json: @role.errors.messages, status: 422
        end
    end

    def update
        if @role.update(role_params)
            render :show, status: :ok
        else
            render json: @role.errors.messages, status: 422
        end
    end

    def destroy
        if @role.destroy
            head :ok
        else
            render json: @role.errors.messages, status: 422
        end
    end

    private
    def set_role
        @role = Role.find(params[:id])
    end

    def role_params
        params.permit(:name)
    end
end