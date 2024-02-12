class AddLockedAtToUsers < ActiveRecord::Migration[6.1]
  def up
    add_column :users, :locked_at, :datetime
  end

  def down
    remove_column :users, :locked_at, :datetime
  end
end
