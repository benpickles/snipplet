class RenameWavesToSnips < ActiveRecord::Migration
  def self.up
    rename_table :waves, :snips
  end

  def self.down
    rename_table :snips, :waves
  end
end
