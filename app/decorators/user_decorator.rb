class UserDecorator < ApplicationDecorator
  delegate_all

  def user_nickname
    return name if name.present?

    email.split('@')[0].capitalize
  end
end
