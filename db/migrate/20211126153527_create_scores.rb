class CreateScores < ActiveRecord::Migration[6.1]
  def change
    create_table :scores do |t|
      t.references :requeriment, null: false, foreign_key: true
      t.string :servico
      t.string :status
      t.float :score
      t.date :date

      t.timestamps
    end
  end
end
