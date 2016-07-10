class AddColumnToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :price, :decimal, precision: 10, scale: 2
  end
end
