module ApplicationHelper
  def selected(user_id, person_id)
    'selected="selected"' if user_id.equal? person_id
  end

  def generate_random_color
    return "#%06x" % (rand * 0xffffff)
  end

  def direction_transcriptor(direction)
    return "Income" if direction
    "Spending"
  end
end
