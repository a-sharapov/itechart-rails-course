class Transaction < ApplicationRecord
  has_one :person
  has_one :category

  validates :amount, presence: true, length: { minimum: 1 }
  validates :description, presence: false, length: { maximum: 120 }
  validates :title, presence: false, format: { without: /\s+\s/ }, length: { maximum: 50 }

  scope :all_important, lambda {
    transactions = where('is_important = true')
  }

  scope :all_by_direction, lambda { |direction|
    transactions = where('direction = ?', direction)
  }

  scope :all_by_person, lambda { |person_id|
    transactions = where('person_id = ?', person_id)
  }

  scope :all_by_category, lambda { |category_id|
    transactions = where('category_id = ?', category_id)
  }
end
