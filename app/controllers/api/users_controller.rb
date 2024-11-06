# frozen_string_literal: true

class Api::UsersController < ApplicationController
  before_action :set_user, only: %i[show update destroy]

  def index
    render json: User.all.to_json(only: %i[id first_name last_name created_at updated_at username email])
  end

  def show
    render json: @user.to_json(only: %i[id first_name last_name created_at updated_at username email])
  end

  def create
    @user = User.new(user_params)
    return head :created if @user.save

    render json: @user.errors, status: :unprocessable_entity
  end

  def update
    if @user.update(user_params)
      render json: @user.to_json(only: %i[id first_name last_name created_at updated_at username email])
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    return head :no_content if @user.destroy

    render json: @user.errors, status: :unprocessable_entity
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.permit(%i[first_name last_name email username])
  end
end
