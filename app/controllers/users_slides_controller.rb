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
      # スライドショー画像の配列をチェックして、選択されていない部分にデフォルトの画像を設定
      (0..2).each do |index|
        position = params[:users_slide][:positions][index].to_i

        # 画像が提供されているか確認し、params[:users_slide][:images]が存在するか確認
        if params[:users_slide][:images].present? && params[:users_slide][:images][index].present?
          image = params[:users_slide][:images][index]
          @users_slide.slide_images.create(image:, position:)
        else
          # デフォルト画像を指定してActiveStorageで扱える形式に変換
          default_image_path = Rails.root.join('app/assets/images/GameFriend.jpg')
          default_image_file = File.open(default_image_path)

          # ActiveStorageで添付する場合はioとfilenameを明示する
          @users_slide.slide_images.create(
            image: {
              io: default_image_file,
              filename: 'GameFriend.jpg',
              content_type: 'image/jpeg' # 適切なMIMEタイプを指定
            },
            position:
          )

          # ファイルを明示的に閉じる（セキュリティとパフォーマンスのため）
          default_image_file.close
        end
      end
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

      # 画像がアップロードされた場合のみ更新
      slide_image.image.attach(slide_image_param[:image]) if slide_image_param[:image].present?

      # positionも更新
      slide_image.update(position: slide_image_param[:position])
    end

    redirect_to @user, notice: 'Slides updated successfully.'
  end

  def show
    @users_slide = @user.users_slides.first
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
    @users_slide = @user.users_slides.first
  end

  def users_slide_params
    params.require(:users_slide).permit(images: [], positions: [])
  end

  def slide_images_params
    params.require(:users_slide).permit(slide_images: %i[id image position])[:slide_images]
  end
end
