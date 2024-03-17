class AddDataToMember < ActiveRecord::Migration[6.1]
  def up
    add_column :members, :data, :jsonb, default: {}
  end

  def down
    remove_column :members, :data
  end
end
