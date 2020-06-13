class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  add_flash_types :success, :info, :warning, :danger
  protected

  # methodをオーバーライドする。
  def configure_permitted_parameters
    sign_up_params = [:name, :employee_number, :password, :password_confirmation]
    sign_in_params = [:employee_number, :password, :remember_me]
    account_update = [:name, :area]
    # account_update, sign_in, sign_up, のフィールドを再定義
    devise_parameter_sanitizer.permit(:sign_up, keys: sign_up_params)
    devise_parameter_sanitizer.permit(:sign_in, keys: sign_in_params)
    devise_parameter_sanitizer.permit(:account_update, keys: account_update)
  end

  def after_sign_in_path_for(resource)
    root_path
  end
end
