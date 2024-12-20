# frozen_string_literal: true

# SlideImagesController
class SlideImagesController < ApplicationController
  before_action :set_user
  def index
    @slide_images = current_user.slide_images.all
  end

  def new; end

  def create; end

  def show
    @slide_images = current_user.slide_images.all
  end

  def change; end

  def update; end

  private

  def set_user
    @user = current_user
  end

  def users_slide_params
    params.require(:users_slide).permit(images: [], positions: [])
  end
end
