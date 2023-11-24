class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :name
      t.string :title
      t.string :company
      t.text :description
      t.decimal :price
      t.integer :user_id
      t.string :location

      t.timestamps
    end
  end
end
