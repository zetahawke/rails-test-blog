class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.string :token
      t.string :payerid
      t.references :user, index: true, foreign_key: true
      t.decimal :total, precision: 10, scale: 2
      t.string :response

      t.timestamps null: false
    end
  end
end
