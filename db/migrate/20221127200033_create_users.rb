class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :eth_address
      t.string :eth_nonce

      t.timestamps
    end
    add_index :users, :eth_address, unique: true
    add_index :users, :eth_nonce, unique: true
  end
end
