class CreateSelfDeclarations < ActiveRecord::Migration[6.1]
  def change
    create_table :self_declarations do |t|
      t.string :type
      t.references :benefit, null: false, foreign_key: true

      t.timestamps
    end
  end
end
