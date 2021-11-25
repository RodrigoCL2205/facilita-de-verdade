class ChangeScoreForServices < ActiveRecord::Migration[6.1]
  def change
    remove_column :score_for_services, :valor
    add_column :score_for_services, :conclusao, :float
    add_column :score_for_services, :exigencia, :float
    add_column :score_for_services, :subtarefa, :float
  end
end
