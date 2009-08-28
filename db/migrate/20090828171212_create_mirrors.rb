class CreateMirrors < ActiveRecord::Migration
  def self.up
    create_table :mirrors do |t|
      t.string :domain, :null => false
      t.boolean :enabled, :null => false, :default => true
      t.boolean :serves_gems, :null => false, :default => false
      t.boolean :serves_files, :null => false, :default => false
      t.string :administrator_name, :default => ""
      t.string :administrator_email, :default => ""
      t.string :url, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :mirrors
  end
end
