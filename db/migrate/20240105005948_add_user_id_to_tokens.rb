class AddUserIdToTokens < ActiveRecord::Migration[6.1]
  def up
    add_column :tokens, :user_id, :integer
  end

  def down
    remove_column :tokens, :user_id
  end
end
