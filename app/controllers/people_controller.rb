class PeopleController < ApplicationController
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :set_user
  before_action :set_person, only: [:show, :edit, :update, :destroy]

  def index
    @people = @user.people
  end

  def show
  end

  def new
    @person = @user.people.build
  end

  def edit
  end

  def create
    @person = @user.people.build(person_params)

    if @person.save
      redirect_to user_root_path, notice: "Person was successfully created."
    else
      render action: 'new'
    end
  end

  def update
    if @person.update(person_params)
      redirect_to user_root_path, notice: "Person was successfully updated."
    else
      render action: 'edit'
    end
  end

  def destroy
    if current_user.people.count > 1
      @person.destroy
      redirect_to user_root_path, notice: "Person was successfully removed."
    else
      redirect_to user_root_path, alert: "You can't destroy yours last alter ego"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = current_user
    end

    def set_person
      @person = current_user.people.friendly.find(params[:id])
    end

    def person_params
      params.require(:person).permit(:name, :relation, :description, :user_id)
    end
end
