class AddMessageSidToSmsMessages < ActiveRecord::Migration[6.1]
  def up
    add_column :sms_messages, :message_sid, :string
    add_index :sms_messages, :message_sid, unique: true
  end

  def down
    remove_column :sms_messages, :message_sid
    remove_index :sms_messages, :message_sid
  end
end
