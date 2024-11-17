# frozen_string_literal: true

# ApplicationController
class ApplicationController < ActionController::Base
  before_action :debug_session
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_unread_notifications_count
  before_action :set_helper_images

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name gender]) # 新規登録時(sign_up時)にname/genderというキーのパラメーターを追加で許可する
  end

  def after_sign_in_path_for(resource)
    root_path  # ここでログイン後のリダイレクト先を変更可能
  end

  private

  def debug_session
    Rails.logger.debug "Session Data: #{session.inspect}"
  end

  def set_unread_notifications_count
    @unread_notifications_count = current_user.notifications.unread.count if user_signed_in?
  end

  def set_helper_images
    @helper_images = HelperImage.order(:position) # 必要に応じて絞り込み条件を追加
  end

end
