class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.string :yo_username
      t.datetime :yo_tfa_sent_at

      t.timestamps
    end
  end
end
