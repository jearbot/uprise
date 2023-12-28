class AddEmailToMember < ActiveRecord::Migration[6.1]
  def up
    add_column :members, :email, :string
    add_index :members, :email, unique: true
  end

  def down
    remove_index :members, :email
    remove_column :members, :email
  end
end
