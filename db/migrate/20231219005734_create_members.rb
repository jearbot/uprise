class CreateMembers < ActiveRecord::Migration[6.1]
  def change
    create_table :members do |t|
      t.string :phone_number, null: :false
      t.string :normalized_phone_number, null: :false, index: { unique: true }
      t.string :name
      t.string :type, null: :false, index: true
      t.boolean :unsubscribed, null: :false, default: false
      t.timestamps
    end
  end
end
