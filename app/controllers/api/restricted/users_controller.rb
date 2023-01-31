# frozen_string_literal: true

class Api::Restricted::UsersController < Api::RestrictedController
  before_action :set_user, only: %i[show update destroy]

  def index
    @users = User.all
  end

  def create
    @user = User.new(user_params)
    return head :created if @user.save

    render_errors @user.errors, status: :unprocessable_entity
  end

  def update
    if @user.update(user_params)
      render :show, status: :ok
    else
      render_errors @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    return head :no_content if @user.destroy

    render_errors @user.errors, status: :unprocessable_entity
  end

  private

  def set_user
    @user = user.find(params[:id])
  end

  def user_params
    params.require(:user).permit(%i[
      first_name last_name username email password
    ])
  end
end
