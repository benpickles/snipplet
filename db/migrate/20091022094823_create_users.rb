class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :email, :username, :null => false
      t.string :name
      t.string :crypted_password
      t.string :password_salt
      t.string :persistence_token
      t.timestamps
    end

    add_index :users, :email, :unique => true
    add_index :users, :username, :unique => true
  end

  def self.down
    drop_table :users
  end
end
