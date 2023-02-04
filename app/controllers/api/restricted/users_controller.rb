# frozen_string_literal: true

class Api::Restricted::UsersController < Api::RestrictedController
  before_action :set_user, only: %i[show update destroy]
  before_action -> { authorize User }, only: %i[create]
  before_action -> { authorize @user }, only: %i[update destroy]

  def index
    render json: User.all, each_serializer: UserSerializer
  end

  def show
    render json: @user
  end

  def create
    @user = User.new(user_params)
    return head :created if @user.save

    render_errors @user, status: :unprocessable_entity
  end

  def update
    if @user.update(user_params)
      render json: @user
    else
      render_errors @user, status: :unprocessable_entity
    end
  end

  def destroy
    return head :no_content if @user.destroy

    render_errors @user, status: :unprocessable_entity
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    ActiveModelSerializers::Deserialization.jsonapi_parse(
      params, only: %i[first_name last_name password email username]
    )
  end
end
