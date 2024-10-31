class AddCategoryToSuperpowers < ActiveRecord::Migration[7.1]
  def change
    add_column :superpowers, :category, :string
  end
end
