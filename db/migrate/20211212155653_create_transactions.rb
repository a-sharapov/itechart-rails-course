class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.string :title
      t.text :description
      t.decimal :amount
      t.boolean :is_important, :default => false
      t.boolean :direction
      t.integer :person_id
      t.integer :category_id

      t.timestamps
    end
    add_index :transactions, :person_id
    add_index :transactions, :category_id
  end
end
