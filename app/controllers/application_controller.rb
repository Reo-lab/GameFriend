class ApplicationController < ActionController::Base
  before_action :debug_session
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_notifications

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :gender]) # 新規登録時(sign_up時)にnameというキーのパラメーターを追加で許可する
  end

  private

  def debug_session
    Rails.logger.debug "Session Data: #{session.inspect}"
  end

  def set_notifications
    if user_signed_in?
      @notifications = current_user.notifications.order(created_at: :desc)
    else
      @notifications = []
    end
  end

end
