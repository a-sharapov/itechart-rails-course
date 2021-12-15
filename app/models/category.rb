class Category < ApplicationRecord
  has_many :person_categories, dependent: :destroy
  has_many :persons, through: :person_categories
  has_many :user_transactions, class_name: "Transaction", dependent: :destroy

  validates :title, presence: true, length: { minimum: 1, maximum: 12 }
  validates :description, presence: false, length: { maximum: 60 }

  scope :all_by_current_user, lambda { |current_user_id|
    categories = includes(:persons, :person_categories)
                 .references(:person_categories)
                 .where('user_id = ?', current_user_id)
                 .order(created_at: :desc)
  }
  scope :all_by_person, lambda { |person_id|
    categories =  includes(:persons, :person_categories)
                  .references(:person_categories)
                  .where('person_id = ?', person_id)
                  .order(created_at: :desc)
  }
end
