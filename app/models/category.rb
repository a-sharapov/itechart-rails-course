class Category < ApplicationRecord
  has_many :person_categories, dependent: :destroy
  has_many :persons, through: :person_categories 
  
  validates :title, presence: true, length: { minimum: 1, maximum: 12 }
  validates :description, presence: false, length: { maximum: 60 }

  # scope :all_by_person, ->(person_id) do 
  #   categories = includes(:persons, :person_categories, :transactions)
  #   categories = categories.joins(:persons).where(person: person_id) if person_id
  #   categories.order(created_at: :desc)
  # end
end
