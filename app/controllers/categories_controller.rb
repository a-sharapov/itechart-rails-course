class CategoriesController < ApplicationController
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :fetch_persons
  before_action :set_person
  before_action :set_categories, only: %i[destroy]
  before_action :set_category, only: %i[show edit destroy]
  before_action :set_category_to_update, only: %i[update]

  def show
    @transactions = Transaction.all_by_person(current_user.current_person).all_by_category(@category.id)
    @fStartDate = Date.today - 1.month
    @fEndDate = Date.today

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
      @transactions = @transactions.where(created_at: startDate.to_date..endDate.to_date + 1.day)
    end
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to user_root_path(anchor: "category-#{@category.id}"), notice: 'Category was successfully created.'
    else
      render action: 'new'
    end
  end

  def edit; end

  def update
    @person
    if @category.update(category_update_params)
      redirect_to user_root_path(anchor: "category-#{@category.id}"), notice: 'Category was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    if @categories.count > 1
      @category.destroy
      redirect_to user_root_path, notice: 'Category was successfully removed.'
    else
      redirect_to user_root_path, alert: "You can't destroy last category"
    end
  end

  private

  def date_params
    params.permit(created_at: [])
  end

  def set_category
    @category = Category.find(params[:category_id])
  end

  def set_category_to_update
    @category = Category.find(category_update_params[:id])
  end

  def set_categories
    @categories = Category
                  .includes(:persons, :person_categories)
                  .references(:person_categories)
                  .where('user_id = ?', current_user.id)
  end

  def set_person
    @person = current_user.people.friendly.find(params[:person_id])
  end

  def category_update_params
    params.require(:category).permit(:id, :title, :direction, :color, :description, person_ids: [])
  end

  def category_params
    params.permit(:title, :direction, :color, :description, person_ids: [])
  end

  def fetch_persons
    @people = current_user.people.all
  end
end
