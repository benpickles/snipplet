class AddOriginalIdToWaves < ActiveRecord::Migration
  def self.up
    add_column :waves, :original_id, :integer
  end

  def self.down
    remove_column :waves, :original_id
  end
end
