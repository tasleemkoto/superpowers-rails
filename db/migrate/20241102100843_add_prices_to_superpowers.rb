class AddPricesToSuperpowers < ActiveRecord::Migration[7.1]
  def change
    add_column :superpowers, :selling_price, :integer
    add_column :superpowers, :renting_price, :integer
  end
end
