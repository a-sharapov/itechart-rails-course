class AddDefaultPersonToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :default_person, :integer
  end
end
