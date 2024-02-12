class CreateSmsMessages < ActiveRecord::Migration[6.1]
  def up
    create_table :sms_messages do |t|
      t.boolean :outbound, null: :false
      t.string :message_body, null: :false
      t.integer :segment_count, null: :false
      t.string :from_number, null: :false
      t.string :to_number, null: :false
      t.integer :delivery_status, null: :false
      t.timestamps
    end
  end

  def down
    drop_table :sms_messages
  end
end
