class CabinetController < ApplicationController
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def index
    @user = current_user
    @people = @user.people.all
  end

  def change_person
    @user = current_user
    if @user.update_without_password(user_params)
      redirect_to user_root_path, notice: 'Active person was successfully changed.'
    else
      redirect_to user_root_path, alert: 'Looks like something goes wrong'
    end
  end

  private

  def user_params
    params.permit(:current_person)
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:current_person])
  end
end
