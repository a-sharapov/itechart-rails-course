class PersonCategory < ApplicationRecord
  belongs_to :category
  belongs_to :person
end
