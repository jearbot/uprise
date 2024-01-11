class CreateTokens < ActiveRecord::Migration[6.1]
  def up
    create_table :tokens do |t|
      t.string :token
      t.string :refresh_token
      t.string :expires_in
      t.string :token_type
      t.string :granted_scopes
      t.datetime :expires_at
      t.timestamps
    end
  end

  def down
    drop_table :tokens
  end
end
