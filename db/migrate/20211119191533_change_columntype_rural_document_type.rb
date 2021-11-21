class ChangeColumntypeRuralDocumentType < ActiveRecord::Migration[6.1]
  def change
    remove_column :rural_document_types, :type
    add_column :rural_document_types, :document, :string
  end
end
