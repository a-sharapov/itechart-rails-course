class UserDecorator < ApplicationDecorator
  delegate_all

  def user_nickname
    return name if name.present?

    email.split('@')[0].capitalize
  end

  def current_person_name
    return Person.friendly.where('id=? and user_id=? ', current_person, id).first.name if current_person.present?
  end

  def current_person_friendly
    return Person.friendly.find(current_person) if current_person.present?
  end
end
