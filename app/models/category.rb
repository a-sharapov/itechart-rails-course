class Category < ApplicationRecord
  has_many :person_categories, dependent: :destroy
  has_many :persons, through: :person_categories 
  
  validates :title, presence: true, length: { minimum: 1, maximum: 12 }
  validates :description, presence: false, length: { maximum: 60 }

  scope :all_by_current_user, ->(current_user_id) do 
    categories = includes(:persons, :person_categories).
                 references(:person_categories).
                 where('user_id = ?', current_user_id).
                 order(created_at: :desc)
  end
  scope :all_by_person, ->(person_id) do 
    categories =  includes(:persons, :person_categories).
                  references(:person_categories).
                  where('person_id = ?', person_id).
                  order(created_at: :desc)
  end
end
