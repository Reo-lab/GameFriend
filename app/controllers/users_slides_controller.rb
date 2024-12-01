# frozen_string_literal: true

# UsersSlidesController
class UsersSlidesController < ApplicationController
  before_action :set_user
  before_action :set_user_slides
  def index
    @user_slides = UsersSlide.all
  end

  def new; end

  def create
    @users_slide = current_user.users_slides.new
    Rails.logger.debug "Params: #{params.inspect}"
    if @users_slide.save
      create_slide_images
      redirect_to user_path(current_user), notice: 'Slide show was successfully created.'
    else
      render :new
    end
  end

  def edit; end

  def update
    Rails.logger.debug "Params: #{params.inspect}"
    slide_images_params.each do |slide_image_param|
      slide_image = SlideImage.find(slide_image_param[:id])
      slide_image.image.attach(slide_image_param[:image]) if slide_image_param[:image].present?
      slide_image.update(position: slide_image_param[:position])
    end
    redirect_to @user, notice: 'Slides updated successfully.'
  end

  def show
    @users_slide = @user.users_slides.includes(:slide_images).first
  end

  def destroy
    @users_slide = @user.users_slides
    @users_slide.destroy
    redirect_to user_users_slides_path(@user), notice: 'Slide show was successfully deleted.'
  end

  private

  def set_user
    @user = current_user
  end

  def set_user_slides
    @users_slide = @user.users_slides.includes(slide_images: { image_attachment: :blob }).first
  end

  def users_slide_params
    params.require(:users_slide).permit(images: [], positions: [])
  end

  def slide_images_params
    params.require(:users_slide).permit(slide_images: %i[id image position])[:slide_images]
  end

  def create_slide_images
    (0..2).each do |index|
      position = params[:users_slide][:positions][index].to_i
      image = get_image_for_slide(index)

      if image.present?
        create_slide_image(image, position)
      else
        attach_default_image(position)
      end
    end
  end

  def get_image_for_slide(index)
    params[:users_slide][:images].present? ? params[:users_slide][:images][index] : nil
  end

  def create_slide_image(image, position)
    @users_slide.slide_images.create(image:, position:)
  end

  def attach_default_image(position)
    default_image_file = load_default_image
    @users_slide.slide_images.create(
      image: {
        io: default_image_file,
        filename: 'GameFriend.jpg',
        content_type: 'image/jpeg'
      },
      position:
    )
    default_image_file.close
  end

  def load_default_image
    default_image_path = Rails.root.join('app/assets/images/GameFriend.jpg')
    File.open(default_image_path)
  end
end
