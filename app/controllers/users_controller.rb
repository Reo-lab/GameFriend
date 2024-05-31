class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @user_realtime_boards = @user.realtime_boards
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

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:name, :gender, :age, :icon_image)
  end
end
