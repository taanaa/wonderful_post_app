class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end

  # def after_sign_in_path_for(resource)
  #   user_path(resource.id)
  # end


end
# before_action :set_locale

# def set_locale
#     I18n.locale = I18n.default_locale
# end
