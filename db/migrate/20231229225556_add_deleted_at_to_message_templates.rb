class AddDeletedAtToMessageTemplates < ActiveRecord::Migration[6.1]
  def up
    add_column :message_templates, :deleted_at, :datetime
  end

  def down
    remove_column :message_templates, :deleted_at
  end
end
