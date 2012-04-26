class Devise::RecaptchaRegistrationsController < Devise::RegistrationsController 

  def create
    passed = !Rails.application.config.recaptcha_enabled
    
    if session[:omniauth].nil?
      if Rails.application.config.recaptcha_enabled
        passed = verify_recaptcha
        flash.delete :recaptcha_error
        if !passed
          flash[:error] = I18n.t('recaptcha.errors.incorrect-captcha-sol') 
        end
      end
      if params[:email] != params[:email_confirmation]
        if passed
          flash[:error] = I18n.t('dmp.auth.unmatched_email')
        end
        passed = false
      end
    end
    
    if !session[:omniauth].nil? || passed
      super
      session[:omniauth] = nil unless @user.new_record?
    else
      build_resource 
      clean_up_passwords(resource)
      respond_with_navigational(resource) { render_with_scope :new }
    end 
  end 

end 
