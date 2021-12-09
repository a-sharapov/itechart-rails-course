class Person < ApplicationRecord
  validates :name, presence: true, length: { minimum: 2 }
  belongs_to :user

  extend FriendlyId
  friendly_id :name, use: :slugged

  def should_generate_new_friendly_id?
    name_changed?
  end

  def normalize_friendly_id(string)
    string.to_slug.transliterate(:russian).normalize.to_s
  end

end
