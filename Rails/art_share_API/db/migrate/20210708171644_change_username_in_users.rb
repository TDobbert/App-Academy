class ChangeUsernameInUsers < ActiveRecord::Migration[6.1]
  def change
    change_column :users, :username, :string, null: false, unique: true
  end
end
