class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :name, :null => false
      t.string :surname, :null => false
      t.string :phone
      t.string :email
      t.text :notes
      t.boolean :active, :default => true

      t.timestamps
    end
  end
end
