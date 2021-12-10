class CabinetController < ApplicationController
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_person_id

  def index
    @user = current_user
    @people = @user.people.all
    if @user.default_person.equal? @user.current_person
      @categories = Category.
                    includes(:persons, :person_categories).
                    references(:person_categories).
                    where('user_id = ?', @user.id).
                    order(created_at: :desc).
                    page(params[:page]).per(7)
    else
      @categories = Category.
                    includes(:persons, :person_categories).
                    references(:person_categories).
                    where('person_id = ?', @person_id).
                    order(created_at: :desc).
                    page(params[:page]).per(7)
    end
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

  def set_person_id
    @person_id = current_user.current_person
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:current_person])
  end
end
