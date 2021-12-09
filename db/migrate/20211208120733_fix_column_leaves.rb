class FixColumnLeaves < ActiveRecord::Migration[6.1]
  def change
    rename_column :leaves, :type, :tipo
  end
end
