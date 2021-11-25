class CreateScoreForServices < ActiveRecord::Migration[6.1]
  def change
    create_table :score_for_services do |t|
      t.string :servico
      t.string :status
      t.float :valor
      t.boolean :antecipa

      t.timestamps
    end
  end
end
