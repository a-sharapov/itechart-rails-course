class CreateCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :categories do |t|
      t.string :title
      t.text :description
      t.string :color
      t.boolean :direction, default: true

      t.timestamps
    end
  end
end
