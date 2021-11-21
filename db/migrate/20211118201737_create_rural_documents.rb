class CreateRuralDocuments < ActiveRecord::Migration[6.1]
  def change
    create_table :rural_documents do |t|
      t.string :type
      t.date :issue_date
      t.date :registration_date
      t.date :validity_start_date
      t.date :validity_end_date
      t.text :note

      t.timestamps
    end
  end
end
