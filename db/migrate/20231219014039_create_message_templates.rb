class CreateMessageTemplates < ActiveRecord::Migration[6.1]
  def change
    create_table :message_templates do |t|
      t.string :name, null: :false
      t.string :body, null: :false
      t.integer :cadence
      t.timestamps
    end
  end
end