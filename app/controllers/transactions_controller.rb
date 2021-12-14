class TransactionsController < ApplicationController
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :set_person, only: %i[new create edit update destroy]
  before_action :set_categories, only: %i[new create edit update]
  before_action :set_transaction, only: %i[show edit destroy]

  def show; end

  def new
    @transaction = Transaction.new
  end

  def create
    @transaction = Transaction.new(transaction_params)
    if @transaction.save
      redirect_to user_root_path(anchor: "transaction-#{@transaction.id}"),
                  notice: 'Transaction was successfully created.'
    else
      render action: 'new', locals: transaction_params
    end
  end

  def edit
    @person
    @categories = Category.all_by_person(@person).where('direction = ?', @transaction.direction)
  end

  def update
    @transaction = Transaction.find(transaction_update_params[:id])
    if @transaction.update(transaction_update_params)
      redirect_to user_root_path(anchor: "transaction-#{@transaction.id}"),
                  notice: 'Transaction was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    if @transaction.destroy
      redirect_to user_root_path, notice: 'Transaction was successfully removed.'
    else
      redirect_to user_root_path, alert: 'Something goes wrong'
    end
  end

  private

  def transaction_params
    params.permit(:person_id, :category_id, :title, :amount, :description, :direction, :is_important)
  end

  def transaction_update_params
    params.require(:transaction).permit(:id, :person_id, :category_id, :title, :amount, :description, :direction,
                                        :is_important)
  end

  def set_person
    @person = current_user.current_person
  end

  def set_transaction
    @transaction = Transaction.all_by_person(@person).find(params[:id])
  end

  def set_categories
    @categories = Category.all_by_person(@person).where('direction = ?', params[:direction])
  end
end
