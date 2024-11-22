# frozen_string_literal: true

# OmniauthCallbacksController
module Users
  # OmniauthCallbacksController
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    skip_before_action :verify_authenticity_token, only: :google_oauth2
    def google_oauth2
      callback_for(:google)
    end

    def callback_for(provider)
      # 先ほどuser.rbで記述したメソッド(from_omniauth)をここで使っています
      # 'request.env["omniauth.auth"]'この中にgoogoleアカウントから取得したメールアドレスや、名前と言ったデータが含まれています
      @user = User.from_omniauth(request.env['omniauth.auth'])
      if @user.persisted?
        sign_in_and_redirect @user, event: :authentication
        set_flash_message(:notice, :success, kind: provider.to_s.capitalize) if is_navigational_format?
      else
        session['devise.google_data'] = request.env['omniauth.auth'].except('extra')
        redirect_to root_path, alert: @user.errors.full_messages.join("\n")
      end
    end

    def failure
      redirect_to root_path
    end
  end
end
