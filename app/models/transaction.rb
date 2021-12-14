class Transaction < ApplicationRecord
  has_one :person
  has_one :category
  
  validates :amount, presence: true, length: { minimum: 1 }
  validates :description, presence: true, length: { maximum: 120 }

  scope :all_important, ->() do 
    transactions = where('is_important = true')
  end
  
  scope :all_by_direction, ->(direction) do 
    transactions = where('direction = ?', direction)
  end

  scope :all_by_person, ->(person_id) do 
    transactions = where('person_id = ?', person_id)
  end

  scope :all_by_category, ->(category_id) do 
    transactions = where('category_id = ?',category_id)
  end
end
