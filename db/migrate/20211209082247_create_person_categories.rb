class CreatePersonCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :person_categories do |t|
      t.belongs_to :category, null: false, foreign_key: true
      t.belongs_to :person, null: false, foreign_key: true

      t.timestamps
    end
    
    add_index :person_categories, [:person_id, :category_id], unique: true
  end
end
