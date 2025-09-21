class CreateSales < ActiveRecord::Migration[7.1]
  def change
    create_table :sales do |t|
      t.references :customer, null: false, foreign_key: true
      t.decimal :value

      t.timestamps
    end
  end
end
