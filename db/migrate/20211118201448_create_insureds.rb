class CreateInsureds < ActiveRecord::Migration[6.1]
  def change
    create_table :insureds do |t|
      t.string :name
      t.string :cpf
      t.string :mothers_name
      t.date :birth_date

      t.timestamps
    end
  end
end
