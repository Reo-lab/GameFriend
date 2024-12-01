# frozen_string_literal: true

require 'base64'

# UsersController
class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update]

  def index
    @users = User.all
  end

  def show
    @users_slide = @user.users_slides.first
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user, notice: 'ユーザーが作成されました.'
    else
      flash[:alert] = @user.errors.full_messages.join(', ')
      render :new
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      handle_icon_image
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
    params.require(:user).permit(:name, :gender, :age, :icon_image, :bio, :discord)
  end

  def handle_icon_image
    if params[:user][:cropped_icon].present?
      attach_cropped_icon
    elsif params[:user][:icon_image].present?
      @user.icon_image.attach(params[:user][:icon_image])
    end
  end

  def attach_cropped_icon
    # Base64形式の画像データをデコードして保存
    image_data = params[:user][:cropped_icon].gsub(%r{^data:image/(png|jpg|jpeg);base64,}, '')
    decoded_image = Base64.decode64(image_data)
    temp_file = Tempfile.new(['cropped_icon', '.jpg'])
    temp_file.binmode
    temp_file.write(decoded_image)
    temp_file.rewind

    @user.icon_image.attach(io: temp_file, filename: 'cropped_icon.jpg')
    temp_file.close
    temp_file.unlink
  end
end
