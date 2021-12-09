class CreateLeaves < ActiveRecord::Migration[6.1]
  def change
    create_table :leaves do |t|
      t.string :type
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
