# frozen_string_literal: true

# ApplicationController
class ApplicationController < ActionController::Base
  before_action :debug_session
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_unread_notifications_count

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name gender]) # 新規登録時(sign_up時)にname/genderというキーのパラメーターを追加で許可する
  end

  private

  def debug_session
    Rails.logger.debug "Session Data: #{session.inspect}"
  end

  def set_unread_notifications_count
    @unread_notifications_count = current_user.notifications.unread.count if user_signed_in?
  end
end
