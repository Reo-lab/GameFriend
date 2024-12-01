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
      @user = User.from_omniauth(request.env['omniauth.auth'])
      if @user.persisted?
        handle_persisted_user(provider)
      else
        handle_new_user
      end
    end

    def failure
      redirect_to root_path
    end

    private

    def handle_persisted_user(provider)
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: provider.to_s.capitalize) if is_navigational_format?
    end

    def handle_new_user
      session['devise.google_data'] = request.env['omniauth.auth'].except('extra')
      redirect_to root_path, alert: @user.errors.full_messages.join("\n")
    end
  end
end
