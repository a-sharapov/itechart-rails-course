class Person < ApplicationRecord
  has_many :person_category, dependent: :destroy
  has_many :category, through: :person_category
  has_many :person_transaction, class_name: "Transaction", dependent: :destroy
  belongs_to :user
  validates :name, presence: true, length: { minimum: 2 }

  extend FriendlyId
  friendly_id :name, use: :slugged

  def should_generate_new_friendly_id?
    name_changed?
  end

  def normalize_friendly_id(string)
    string.to_slug.transliterate(:russian).normalize.to_s
  end
end
