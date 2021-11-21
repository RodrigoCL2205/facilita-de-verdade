class RemoveTypesToRuralDocuments < ActiveRecord::Migration[6.1]
  def change
    remove_column :rural_documents, :type
  end
end
