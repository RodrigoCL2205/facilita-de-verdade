class AddColumnToRequeriments < ActiveRecord::Migration[6.1]
  def change
    add_column :requeriments, :status, :string
    add_column :requeriments, :servico, :string
  end
end
