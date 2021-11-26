class AddColumnToScores < ActiveRecord::Migration[6.1]
  def change
    add_reference :scores, :work_period, null: false, foreign_key: true
  end
end
