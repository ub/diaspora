# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def google_oauth2
    user = ::User.from_omniauth(oauth_response)
    # created user is never persisted because username is not filled until registration
    if user.persisted?
      flash[:notice] = I18n.t("devise.omniauth_callbacks.success", kind: user.provider)
      sign_in_and_redirect user, event: :authentication
    else
      session["devise.google_data"] = oauth_response.except(:extra)
      redirect_to new_user_registration_with_google_path
    end
  end
  # More info at:
  # https://github.com/plataformatec/devise#omniauth


  protected

  def oauth_response
    request.env["omniauth.auth"]
  end

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end
end
