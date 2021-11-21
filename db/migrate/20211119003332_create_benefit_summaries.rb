class CreateBenefitSummaries < ActiveRecord::Migration[6.1]
  def change
    create_table :benefit_summaries do |t|
      t.references :benefit, null: false, foreign_key: true
      t.date :issue_date
      t.string :number
      t.string :species
      t.date :der
      t.integer :despacho
      t.integer :motivo
      t.integer :motivo1
      t.integer :motivo2
      t.string :name
      t.string :sex
      t.date :birth_date
      t.string :nit
      t.string :cpf
      t.string :mothers_name
      t.integer :ra
      t.integer :ff
      t.date :dib
      t.date :dip
      t.date :datdd
      t.date :data_licenca
      t.integer :tipo_licenca
      t.date :dodr
      t.string :tempo_beneficio

      t.timestamps
    end
  end
end
