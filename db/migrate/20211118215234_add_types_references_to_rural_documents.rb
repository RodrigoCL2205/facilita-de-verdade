class AddTypesReferencesToRuralDocuments < ActiveRecord::Migration[6.1]
  def change
    add_reference :rural_documents, :rural_document_type, foreign_key: true
  end
end
