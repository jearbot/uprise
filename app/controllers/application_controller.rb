class ApplicationController < ActionController::Base
  before_action :authenticate_user!, unless: [:devise_controller?, :callback_controller?]

  def devise_controller?
    is_a?(Devise::SessionsController) || is_a?(Devise::PasswordsController)
  end

  def callback_controller?
    is_a?(Callbacks::BaseController)
  end

  protect_from_forgery with: :null_session

end
