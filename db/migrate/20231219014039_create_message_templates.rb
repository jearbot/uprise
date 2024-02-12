class CreateMessageTemplates < ActiveRecord::Migration[6.1]
  def up
    create_table :message_templates do |t|
      t.string :name, null: :false
      t.string :body, null: :false
      t.integer :cadence
      t.timestamps
    end
  end

  def down
    drop_table :message_templates
  end
end