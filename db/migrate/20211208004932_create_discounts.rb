class CreateDiscounts < ActiveRecord::Migration[6.1]
  def change
    create_table :discounts do |t|
      t.date :date
      t.float :value

      t.timestamps
    end
  end
end
