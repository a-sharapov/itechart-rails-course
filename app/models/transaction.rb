class Transaction < ApplicationRecord
  belongs_to :person, foreign_key: "person_id"
  belongs_to :category, foreign_key: "category_id"

  validates :amount, presence: true, length: { minimum: 1 }
  validates :description, presence: false, length: { maximum: 120 }
  validates :title, presence: false, format: { without: /\s+\s/ }, length: { maximum: 50 }
  validates :person_id, presence: true
  validates :category_id, presence: true

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
