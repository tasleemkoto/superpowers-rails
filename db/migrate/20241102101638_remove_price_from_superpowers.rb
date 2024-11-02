class RemovePriceFromSuperpowers < ActiveRecord::Migration[7.1]
  def change
    remove_column :superpowers, :price, :integer
  end
end
