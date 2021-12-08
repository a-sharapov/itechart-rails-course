class Static < ApplicationRecord
  validates :title, presence: true

  extend FriendlyId
  friendly_id :title, use: :slugged

  def should_generate_new_friendly_id?
    title_changed?
  end

  def normalize_friendly_id(string)
    string.to_slug.transliterate(:russian).normalize.to_s
  end
end
