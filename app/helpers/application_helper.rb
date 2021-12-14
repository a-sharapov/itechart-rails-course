module ApplicationHelper
  def selected(first,second)
    'selected="selected"' if first.equal? second
  end

  def checked(condition)
    'selected="selected"' if condition
  end

  def generate_random_color
    return "#%06x" % (rand * 0xffffff)
  end

  def direction_transcriptor(direction)
    return "Income" if direction
    "Spending"
  end

  def summ_transactions(transactions)
    format("%.2f", transactions.sum(&:amount))
  end

  def return_setted(first,second)
    return first if first.present?
    second
  end
    
end
