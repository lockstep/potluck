class Users::RegistrationsController < Devise::RegistrationsController
# before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]
  def create
    super
    UserMailer.welcome_new_user(resource).deliver_now unless resource.invalid?
  end

  protected

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  def configure_account_update_params
    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(:first_name, :last_name, :email)
    end
  end
end
