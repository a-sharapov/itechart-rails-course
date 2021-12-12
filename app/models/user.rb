class User < ApplicationRecord
  has_many :people, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  extend FriendlyId
  friendly_id :email, use: :slugged

  def should_generate_new_friendly_id?
    email_changed?
  end

  after_create :create_assigned_assets

  def normalize_friendly_id(string)
    string.to_slug.transliterate(:russian).normalize.to_s
  end

  private

  def create_assigned_assets
    person = people.build(user_id: id, name: email, description: 'Default person')
    if person.save
      update_without_password(current_person: person.id) 
      update_without_password(default_person: person.id)
      # creating 2 default categories
      category_income = person.category.build(person_ids: [person.id], title: "Income", direction: true, color: "#00a100")
      category_spending = person.category.build(person_ids: [person.id], title: "Spending", direction: false, color: "#e51010")
      category_income.save
      category_spending.save
    end
  end
end
