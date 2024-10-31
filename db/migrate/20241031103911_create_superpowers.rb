class CreateSuperpowers < ActiveRecord::Migration[7.1]
  def change
    create_table :superpowers do |t|
      t.string :title
      t.text :description
      t.integer :price
      t.string :type
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
