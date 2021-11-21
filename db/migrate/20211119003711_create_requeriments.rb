class CreateRequeriments < ActiveRecord::Migration[6.1]
  def change
    create_table :requeriments do |t|
      t.integer :protocol
      t.date :der
      t.references :user, null: false, foreign_key: true
      t.references :insured, null: false, foreign_key: true
      t.references :benefit, null: false, foreign_key: true

      t.timestamps
    end
  end
end
