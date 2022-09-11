class CurrentUserController < ApplicationController
  before_action :authenticate_user!
  skip_load_and_authorize_resource
  def index
    render json: UserSerializer.new(current_user).serializable_hash[:data][:attributes], status: :ok
  end

  def update
    if current_user.update(user_params)
      render json: UserSerializer.new(current_user).serializable_hash[:data][:attributes], status: :ok
    else
      render json: current_user.errors.full_messages, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :country, :phone, :image)
  end
end
