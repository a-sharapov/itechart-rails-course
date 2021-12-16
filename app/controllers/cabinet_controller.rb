class CabinetController < ApplicationController
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_person_id

  def index
    @user = current_user
    @people = @user.people.all
    @fStartDate = Date.today - 1.month
    @fEndDate = Date.today

    @categories = if @user.default_person.equal? @user.current_person
                    Category.all_by_current_user(@user.id)
                  else
                    Category.all_by_person(@person_id)
                  end

    @transactions = Transaction.all_by_person(@person_id)
                               .where(created_at: 1.month.ago..Date.today + 1.day)

    case true
    when params[:only_imporant].eql?('true')
      @transactions = @transactions
                      .where('is_important = true')

    when params[:only_with_description].eql?('true')
      @transactions = @transactions
                      .where.not(description: [nil, ''])

    when date_params.present?
      date_p = date_params
      (@fStartDate, @fEndDate) = date_p[:created_at]
      (startDate, endDate) = date_p[:created_at]
      # Фильтрация категорий, по времени создания = забавные графики
      #@categories = @categories.where(created_at: startDate.to_date..endDate.to_date+1.day)
      @transactions = @transactions.where(created_at: startDate.to_date..endDate.to_date + 1.day)

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

  def date_params
    params.permit(created_at: [])
  end

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
