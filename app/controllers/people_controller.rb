class PeopleController < ApplicationController
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :set_user
  before_action :set_person, only: %i[show edit update destroy]

  def index
    @people = @user.people.order(created_at: :desc).page(params[:page]).per(5)
  end

  def new
    @person = @user.people.build
  end

  def edit; end

  def create
    @person = @user.people.build(person_params)

    if @person.save
      redirect_to people_path(anchor: "person-#{@person.id}"), notice: 'Person was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @person.update(person_params)
      redirect_to people_path(anchor: "person-#{@person.id}"), notice: 'Person was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    if [current_user.current_person, current_user.default_person].include? @person.id
      redirect_to people_path, alert: "You can't destroy yours first or active alter ego"
    else
      @person.destroy
      redirect_to people_path, notice: 'Person was successfully removed.'
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
