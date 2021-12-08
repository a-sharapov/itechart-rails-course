module ApplicationHelper
  def selected(user_id, person_id)
    'selected="selected"' if user_id.equal? person_id
  end
end
