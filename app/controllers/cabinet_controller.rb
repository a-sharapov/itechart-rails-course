class CabinetController < ApplicationController
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  def index
    @user = current_user
    @people = @user.people.all
  end
end