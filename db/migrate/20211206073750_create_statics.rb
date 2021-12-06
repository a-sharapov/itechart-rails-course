class CreateStatics < ActiveRecord::Migration[6.1]
  def change
    create_table :statics do |t|
      t.string :title
      t.text :content
      t.text :introtext
      t.string :slug

      t.timestamps
    end
    add_index :statics, :slug, unique: true
  end
end
