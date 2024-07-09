class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  

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
      redirect_to @user, notice: "User was successfully created."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      if params[:user][:icon_image].present?
        @user.icon_image.attach(params[:user][:icon_image])
      end
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :gender, :age, :icon_image)
  end
end
