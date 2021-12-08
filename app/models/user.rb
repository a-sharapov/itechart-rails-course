class User < ApplicationRecord
  has_many :people,:dependent => :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  extend FriendlyId
    friendly_id :email, use: :slugged
       
  def should_generate_new_friendly_id?
    email_changed?
  end

  after_create :create_assigned_person

  private
  def create_assigned_person
    person = people.build(user_id: id, name: "Me")
    update_without_password(current_person: person.id) if person.save
  end

  def normalize_friendly_id(string)
    string.to_slug.transliterate(:russian).normalize.to_s
  end
end
