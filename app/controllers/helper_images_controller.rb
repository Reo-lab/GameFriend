class HelperImagesController < ApplicationController
    def index
        @@helper_images = HelperImage.all
    end
    def new
        @helper_image = HelperImage.new
    end

    def create
        @helper_image = HelperImage.new(image_params)
      if @helper_image.save
        redirect_to @helper_image, notice: '画像が保存されました。'
      else
        render :new
      end
    end

    private

    def set_image
      @helper_image = HelperImage.find(params[:id])
    end

    def image_params
      params.require(:helper_image).permit(:title, :position, :image_file)
    end
end
