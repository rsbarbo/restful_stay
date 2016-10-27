class AddApiKeyToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :api_key, :string
    add_index :users, :api_key, unique: true
  end
end
