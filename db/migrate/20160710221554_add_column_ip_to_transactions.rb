class AddColumnIpToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :ip_address, :string
  end
end
