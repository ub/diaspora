# frozen_string_literal: true

#   Copyright (c) 2010-2011, Diaspora Inc.  This file is
#   licensed under the Affero General Public License version 3 or later.  See
#   the COPYRIGHT file.

class OmniauthRegistrationsController < Devise::RegistrationsController

  layout -> { request.format == :mobile ? "application" : "with_header" }

  def new
    @user = ::User.from_omniauth session["devise.google_data"]
    respond_with @user
  end

  def create
    @user = ::User.from_omniauth session["devise.google_data"]
    if AppConfig.settings.captcha.enable?
      @user.captcha = user_params[:captcha]
      @user.captcha_key = user_params[:captcha_key]
    end
    @user.setup user_params

    if @user.sign_up
      flash[:notice] = t("registrations.create.success")
      @user.seed_aspects
      @user.send_welcome_message
      sign_in_and_redirect(:user, @user)
      logger.info "event=registration status=successful user=#{@user.diaspora_handle}"
    else
      @user.errors.delete(:person)

      flash.now[:error] = @user.errors.full_messages.join(" - ")
      logger.info "event=registration status=failure errors='#{@user.errors.full_messages.join(', ')}'"
      render action: "new"
    end
  end

  private


  def user_params
    params.require(:user).permit(
      :username, :email, :getting_started, :password, :password_confirmation, :language, :disable_mail,
      :show_community_spotlight_in_stream, :auto_follow_back, :auto_follow_back_aspect_id,
      :remember_me, :captcha, :captcha_key
    )
  end
end
