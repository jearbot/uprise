class AddArchivedToMembers < ActiveRecord::Migration[6.1]
  def up
    add_column :members, :archived, :boolean, default: false
  end

  def down
    remove_column :members, :archived
  end
end
