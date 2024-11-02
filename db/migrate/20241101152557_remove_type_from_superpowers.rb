class RemoveTypeFromSuperpowers < ActiveRecord::Migration[7.1]
  def change
    remove_column :superpowers, :type, :string
  end
end
