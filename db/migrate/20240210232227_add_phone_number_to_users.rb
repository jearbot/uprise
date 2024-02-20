class AddPhoneNumberToUsers < ActiveRecord::Migration[6.1]
  def up
    add_column :users, :phone_number, :string
    add_column :users, :normalized_phone_number, :string
  end

  def down
    remove_column :users, :phone_number
    remove_column :users, :normalized_phone_number
  end
end
