# frozen_string_literal: true

# UsersController
class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update]

  def index
    @users = User.all
  end

  def show
    @user = current_user
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user, notice: 'User was successfully created.'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      @user.icon_image.attach(params[:user][:icon_image]) if params[:user][:icon_image].present?
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  def destroy; end

  def icon
    user = User.find(params[:id])
    if user.icon_image.attached?
      render json: { url: url_for(user.icon_image) }
    else
      render json: { url: ActionController::Base.helpers.asset_path('default_user_icon.png') } # デフォルトアイコン
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :gender, :age, :icon_image)
  end
end
