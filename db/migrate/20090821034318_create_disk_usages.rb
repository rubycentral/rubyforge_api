class CreateDiskUsages < ActiveRecord::Migration
  def self.up
    create_table :disk_usages do |t|
      t.integer :group_id, :null => false
      t.integer :scm_space_used, :default => 0
      t.integer :released_files_space_used, :default => 0
      t.integer :virtual_host_space_used, :default => 0
      t.timestamps
    end
  end

  def self.down
    drop_table :disk_usages
  end
end
