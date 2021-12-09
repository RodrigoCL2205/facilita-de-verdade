class ChangeLeavesToLicense < ActiveRecord::Migration[6.1]
  def change
    rename_table :leaves, :licenses
  end
end
