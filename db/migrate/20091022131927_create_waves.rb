class CreateWaves < ActiveRecord::Migration
  def self.up
    create_table :waves do |t|
      t.string :command, :note, :uri
      t.integer :user_id, :null => false
      t.timestamps
    end

    add_index :waves, [:user_id, :command], :unique => true
  end

  def self.down
    drop_table :waves
  end
end
