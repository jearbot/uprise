class CreateMembers < ActiveRecord::Migration[6.1]
  def up
    create_table :members do |t|
      t.string :phone_number, null: :false
      t.string :normalized_phone_number, null: :false, index: { unique: true }
      t.string :name
      t.integer :member_type, null: :false, index: true
      t.boolean :unsubscribed, null: :false, default: false
      t.timestamps
    end
  end

  def down
    drop_table :members
  end
end
