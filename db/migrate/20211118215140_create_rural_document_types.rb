class CreateRuralDocumentTypes < ActiveRecord::Migration[6.1]
  def change
    create_table :rural_document_types do |t|
      t.string :type

      t.timestamps
    end
  end
end
