class AddColumnToLeaves < ActiveRecord::Migration[6.1]
  def change
    add_reference :leaves, :user, null: false, foreign_key: true
  end
end
