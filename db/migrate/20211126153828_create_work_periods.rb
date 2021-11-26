class CreateWorkPeriods < ActiveRecord::Migration[6.1]
  def change
    create_table :work_periods do |t|
      t.references :user
      t.string :program
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
